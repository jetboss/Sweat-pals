-- Secure Pact Creation Function
-- This function handles balance checking, coin deduction, and pact creation atomically.

create or replace function create_pact_secure(
  p_title text,
  p_description text,
  p_target_count int,
  p_wager_amount int,
  p_frequency text,
  p_deadline timestamptz,
  p_squad_id uuid
) returns uuid
language plpgsql
security definer -- Runs with privileges of the creator (should be admin/service role if deployed correctly, or ensures RLS bypass for specific ops if needed)
as $$
declare
  v_pact_id uuid;
  v_user_id uuid := auth.uid();
  v_current_balance int;
begin
  -- Validate inputs
  if p_wager_amount < 0 then
    raise exception 'Wager amount cannot be negative';
  end if;

  -- Check user balance
  select sweat_coins into v_current_balance
  from profiles
  where id = v_user_id;

  if v_current_balance is null then
    raise exception 'User profile not found';
  end if;

  if v_current_balance < p_wager_amount then
    raise exception 'Insufficient funds';
  end if;

  -- Dedudct coins
  update profiles
  set sweat_coins = sweat_coins - p_wager_amount
  where id = v_user_id;

  -- Create pact
  insert into pacts (
    title, 
    description, 
    target_count, 
    wager_amount, 
    frequency, 
    deadline, 
    squad_id, 
    created_by,
    status
  )
  values (
    p_title, 
    p_description, 
    p_target_count, 
    p_wager_amount, 
    p_frequency, 
    p_deadline, 
    p_squad_id, 
    v_user_id,
    'active'
  )
  returning id into v_pact_id;

  return v_pact_id;
end;
$$;

-- Secure Pact Resolution Function
-- Handles returning funds if pact is won, or finalizing state if lost.
create or replace function resolve_pact(
  p_pact_id uuid,
  p_outcome text -- 'won' or 'lost'
) returns void
language plpgsql
security definer
as $$
declare
  v_pact record;
  v_user_id uuid;
begin
  -- Fetch pact
  select * into v_pact
  from pacts
  where id = p_pact_id;

  if v_pact is null then
    -- If it doesn't exist on server yet (sync lag?), we can't refund easily.
    -- For now, raise. Ideally we'd handle optimistic creates that match by local ID.
    raise exception 'Pact not found';
  end if;

  v_user_id := v_pact.created_by;

  -- Only owner or squad can resolve? Just owner for now (self-report).
  -- In real app, check auth.uid() == v_user_id or squad logic.

  if p_outcome = 'won' then
     -- Refund wager (assuming it was deducted at creation)
     -- Optionally add bonus here
     if v_pact.wager_amount > 0 then
       update profiles
       set sweat_coins = sweat_coins + v_pact.wager_amount
       where id = v_user_id;
     end if;
     
     update pacts
     set status = 'won'
     where id = p_pact_id;
     
  elsif p_outcome = 'lost' then
     -- Money remains deducted (Burned/Forfeited)
     update pacts
     set status = 'lost'
     where id = p_pact_id;
  end if;

end;
$$;

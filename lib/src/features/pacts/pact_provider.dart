import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import '../../database/app_database.dart';
import '../../models/pact.dart' as models;
import '../../models/user_profile.dart';
import '../../providers/user_provider.dart';
import '../../services/sync_queue_service.dart';
import 'package:sweat_pals/main.dart';

final pactsProvider = AsyncNotifierProvider<PactNotifier, List<models.Pact>>(PactNotifier.new);

class PactNotifier extends AsyncNotifier<List<models.Pact>> {
  @override
  Future<List<models.Pact>> build() async {
    return _fetchPacts();
  }

  Future<List<models.Pact>> _fetchPacts() async {
    final db = ref.read(appDatabaseProvider);
    final rows = await db.select(db.pactsTable).get();
    
    return rows.map((row) => models.Pact(
      id: row.id,
      userId: 'current_user', // Placeholder, in real app linked to auth
      squadId: row.squadId,
      title: row.title,
      frequency: row.frequency,
      targetCount: row.targetCount,
      wagerAmount: 0, // Placeholder, not in DB yet
      currentStreak: row.currentStreak,
      deadline: DateTime.now().add(const Duration(days: 7)), // Dynamic deadline logic needed
      status: row.status,
      lastCheckedAt: row.lastCheckedAt,
      createdAt: row.createdAt,
    )).toList();
  }

  Future<void> createPact({
    required String title,
    required String frequency,
    required int targetCount,
    required int wagerAmount,
  }) async {
    final db = ref.read(appDatabaseProvider);
    final user = ref.read(userProvider).value;
    final uuid = const Uuid().v4();
    final deadline = DateTime.now().add(Duration(days: frequency == 'weekly' ? 7 : 1));

    // 1. Optimistic Local Update
    final newPact = PactsTableCompanion(
      id: drift.Value(uuid),
      title: drift.Value(title),
      frequency: drift.Value(frequency),
      targetCount: drift.Value(targetCount),
      wagerAmount: drift.Value(wagerAmount.toDouble()),
      currentStreak: const drift.Value(0),
      status: const drift.Value('active'),
      createdAt: drift.Value(DateTime.now()),
      deadline: drift.Value(deadline),
      squadId: drift.Value(user?.partnerId), 
    );

    await db.into(db.pactsTable).insert(newPact);

    // 2. Queue for Sync (with Rollback potential)
    // We trust the RPC to handle the deduction securely
    await ref.read(syncQueueProvider).queueAction('create_pact', {
      'id': uuid, // Pass ID to match local
      'title': title,
      'description': 'Created via App',
      'target_count': targetCount,
      'wager_amount': wagerAmount,
      'frequency': frequency,
      'deadline': deadline.toIso8601String(),
      'squad_id': user?.partnerId,
    });

    state = AsyncValue.data(await _fetchPacts());
  }

  Future<void> incrementStreak(String pactId) async {
    final db = ref.read(appDatabaseProvider);
    final pact = await (db.select(db.pactsTable)..where((tbl) => tbl.id.equals(pactId))).getSingle();
    
    final newStreak = pact.currentStreak + 1;
    
    await (db.update(db.pactsTable)..where((tbl) => tbl.id.equals(pactId))).write(
      PactsTableCompanion(
        currentStreak: drift.Value(newStreak),
        lastCheckedAt: drift.Value(DateTime.now()),
      ),
    );
    
    state = AsyncValue.data(await _fetchPacts());
  }
  Future<void> checkPactStatus() async {
    final db = ref.read(appDatabaseProvider);
    final pacts = await (db.select(db.pactsTable)..where((tbl) => tbl.status.equals('active'))).get();
    
    for (final pact in pacts) {
      // Logic:
      // If frequency is weekly, we check if 7 days passed since createdAt (or last reset).
      // For MVP, simplistic check:
      // If now > createdAt + 7 days AND currentStreak < targetCount -> RESET.
      
      // Real implementation would track "periodStart" and "periodEnd".
      // Assuming 'createdAt' is the start of the current period for now.
      
      final periodEnd = pact.createdAt.add(const Duration(days: 7)); // Weekly default
      
      if (DateTime.now().isAfter(periodEnd)) {
        if (pact.currentStreak < pact.targetCount) {
          // FAILED! Use "Intimate Accountability" -> You LOSE the stake.
          // Update local status to 'lost'
           await (db.update(db.pactsTable)..where((tbl) => tbl.id.equals(pact.id))).write(
             PactsTableCompanion(
               status: const drift.Value('lost'),
               currentStreak: const drift.Value(0),
             ),
           );
           
           // Queue server resolution (burns funds on server)
           ref.read(syncQueueProvider).queueAction('resolve_pact', {
             'id': pact.id,
             'outcome': 'lost',
           });
           
        } else {
           // SUCCESS!
           // For MVP, we auto-extend the period (keep the streak alive).
           // Money stays staked.
           // Future: Allow user to "Cash Out" manually to trigger 'won' resolution.
           
           await (db.update(db.pactsTable)..where((tbl) => tbl.id.equals(pact.id))).write(
             PactsTableCompanion(
               // Start new period
               createdAt: drift.Value(DateTime.now()), 
               currentStreak: const drift.Value(0), // Reset streak for new week, but keep pact active? 
               // Wait, if it's "Streak", it should probably persist total streak? 
               // But "Target Count" is usually "3 times PER week". 
               // So we reset the weekly counter (currentStreak) but maybe increment a totalCycles?
               // Let's reset currentStreak to 0 for the new week to track weekly progress.
             ),
          );
        }
      }
    }
    state = AsyncValue.data(await _fetchPacts());
  }
}

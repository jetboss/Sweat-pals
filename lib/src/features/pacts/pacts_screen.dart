import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import '../../theme/app_colors.dart';
import 'pact_provider.dart';
import '../../models/pact.dart';
import '../../providers/user_provider.dart';

class PactsScreen extends ConsumerStatefulWidget {
  const PactsScreen({super.key});

  @override
  ConsumerState<PactsScreen> createState() => _PactsScreenState();
}

class _PactsScreenState extends ConsumerState<PactsScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    final sweatCoins = userAsync.value?.sweatCoins ?? 0;
    final pactsAsync = ref.watch(pactsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Accountability Pacts"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Wallet Card
                  _buildWalletCard(sweatCoins),
                  const SizedBox(height: 24),
                  
                  // Pacts List
                  const Text("Your Active Pacts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  
                  Expanded(
                    child: pactsAsync.when(
                      data: (pacts) {
                        if (pacts.isEmpty) {
                          return _buildEmptyState();
                        }
                        return ListView.separated(
                          itemCount: pacts.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return _buildPactCard(pacts[index]);
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text("Error: $err")),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreatePactModal(context, sweatCoins),
        label: const Text("New Pact"),
        icon: const Icon(Icons.verified_user_outlined),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildWalletCard(int coins) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade800, Colors.orange.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text("SWEAT COINS", style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 2)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.monetization_on_rounded, color: Colors.white, size: 32),
              const SizedBox(width: 8),
              Text(
                "$coins",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Stake coins to hold yourself accountable.",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.handshake_outlined, size: 60, color: AppColors.textSecondary),
          SizedBox(height: 16),
          Text(
            "No active pacts",
            style: TextStyle(fontSize: 18, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            "Create a wager to boost your motivation!",
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildPactCard(Pact pact) {
    final isExpired = DateTime.now().isAfter(pact.deadline);
    
    // Status Logic (Visual)
    Color statusColor = Colors.blue;
    IconData statusIcon = Icons.timelapse;
    
    if (pact.status == 'won') {
      statusColor = Colors.green;
      statusIcon = Icons.emoji_events;
    } else if (pact.status == 'lost') {
      statusColor = Colors.red;
      statusIcon = Icons.thumb_down;
    } else if (isExpired && pact.status == 'active') {
      statusColor = Colors.orange; // Pending validation
      statusIcon = Icons.hourglass_bottom;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(statusIcon, color: statusColor),
        ),
        title: Text(pact.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                 Icon(Icons.repeat, size: 14, color: AppColors.textSecondary),
                 SizedBox(width: 4),
                 Text("Goal: ${pact.targetCount}x / ${pact.frequency}", style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                 Icon(Icons.local_fire_department, size: 14, color: Colors.orange),
                 SizedBox(width: 4),
                 Text("Current Streak: ${pact.currentStreak}", style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.monetization_on, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text("${pact.wagerAmount} coins staked", style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ],
        ),
        trailing: pact.status == 'active' && !isExpired
            ? _buildProgressIndicator(pact) 
            : Chip(
                label: Text(pact.status.toUpperCase()),
                backgroundColor: statusColor.withValues(alpha: 0.1),
                labelStyle: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget _buildProgressIndicator(Pact pact) {
     // Visual placeholder for progress
     final progress = (pact.currentStreak % pact.targetCount) / pact.targetCount;
     return CircularProgressIndicator(value: progress > 0 ? progress : 0.1, strokeWidth: 4, backgroundColor: Colors.black12);
  }

  void _showCreatePactModal(BuildContext context, int currentCoins) {
    final titleController = TextEditingController(text: "3 Workouts");
    final targetController = TextEditingController(text: "3");
    double wager = 10;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              top: 24, left: 24, right: 24
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Create a Pact", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text("Set a goal and stake your coins.", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),
                
                // Title
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Pact Title",
                    border: OutlineInputBorder(),
                    hintText: "e.g. Crush Week 1"
                  ),
                ),
                const SizedBox(height: 16),
                
                // Target
                TextField(
                  controller: targetController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Target Workouts (Weekly)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Wager Slider
                Text("Wager: ${wager.round()} Coins", style: const TextStyle(fontWeight: FontWeight.bold)),
                Slider(
                  value: wager,
                  min: 5,
                  max: currentCoins > 5 ? currentCoins.toDouble() : 5,
                  divisions: (currentCoins / 5).floor() > 0 ? (currentCoins / 5).floor() : 1,
                  label: wager.round().toString(),
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    setState(() => wager = val);
                  },
                ),
                
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (currentCoins < wager) {
                        ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text("Insufficient coins!"))
                        );
                        return;
                      }

                      try {
                        await ref.read(pactsProvider.notifier).createPact(
                          title: titleController.text, 
                          frequency: 'weekly', // Hardcoded for MVP
                          targetCount: int.tryParse(targetController.text) ?? 3, 
                          wagerAmount: wager.round(),
                        );
                        
                        if (ctx.mounted) ctx.pop();
                        HapticFeedback.mediumImpact();
                        _confettiController.play();
                        
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text("Pact Created! let's go! 🚀"), backgroundColor: AppColors.success)
                          );
                        }
                      } catch (e) {
                         if (context.mounted) {
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text("Error: $e"))
                          );
                         }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Seal the Pact", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(width: 8),
                        Icon(Icons.handshake_rounded, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:confetti/confetti.dart';
import '../../theme/app_colors.dart';
import '../../services/database_service.dart';
import '../../providers/user_provider.dart';

class PactsScreen extends ConsumerStatefulWidget {
  const PactsScreen({super.key});

  @override
  ConsumerState<PactsScreen> createState() => _PactsScreenState();
}

class _PactsScreenState extends ConsumerState<PactsScreen> {
  final _db = DatabaseService();
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
    final user = ref.watch(userProvider);
    final sweatCoins = user?.sweatCoins ?? 0; // Use Hive or fetch from DB? Ideally Hive syncs.
    
    // For now, let's also fetch from DB profile stream if userProvider isn't syncing fast enough with transactional updates?
    // Actually userProvider reads from Hive. We need to make sure Hive gets updated.
    // Sync logic helps, but let's assume Hive is eventual consistent.
    // Or we can stream profile for this screen specifically for realtime coin updates.

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
                  const Text("Your Wagers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  
                  Expanded(
                    child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: _db.streamMyPacts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return _buildEmptyState();
                        }
                        
                        final pacts = snapshot.data!;
                        return ListView.separated(
                          itemCount: pacts.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return _buildPactCard(pacts[index]);
                          },
                        );
                      },
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
            color: Colors.orange.withOpacity(0.3),
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.handshake_outlined, size: 60, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          Text(
            "No active pacts",
            style: TextStyle(fontSize: 18, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            "Create a wager to boost your motivation!",
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildPactCard(Map<String, dynamic> pact) {
    final status = pact['status'] as String;
    final title = pact['title'] as String;
    final wager = pact['wager_amount'] as int;
    final target = pact['target_count'] as int;
    final deadline = DateTime.parse(pact['deadline']).toLocal();
    final isExpired = DateTime.now().isAfter(deadline);
    
    // Status Logic (Visual)
    Color statusColor = Colors.blue;
    IconData statusIcon = Icons.timelapse;
    
    if (status == 'won') {
      statusColor = Colors.green;
      statusIcon = Icons.emoji_events;
    } else if (status == 'lost') {
      statusColor = Colors.red;
      statusIcon = Icons.thumb_down;
    } else if (isExpired && status == 'active') {
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
            color: statusColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(statusIcon, color: statusColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.monetization_on, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text("$wager coins staked", style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text("End: ${DateFormat('MMM d, h:mm a').format(deadline)}", style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ],
        ),
        trailing: status == 'active' && !isExpired
            ? _buildProgressIndicator() // Mock progress
            : Chip(
                label: Text(status.toUpperCase()),
                backgroundColor: statusColor.withOpacity(0.1),
                labelStyle: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
     // Ideally fetch actual progress (logs count vs target)
     return const CircularProgressIndicator(value: 0.3, strokeWidth: 4, backgroundColor: Colors.black12);
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
                    labelText: "Target Workouts",
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
                        final deadline = DateTime.now().add(const Duration(days: 7)); // Hardcode 7 days for MVP
                        await _db.createPact(
                          title: titleController.text, 
                          targetCount: int.tryParse(targetController.text) ?? 3, 
                          wagerAmount: wager.round(), 
                          deadline: deadline
                        );
                        Navigator.pop(ctx);
                        HapticFeedback.mediumImpact();
                        ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text("Pact Created! let's go! 🚀"), backgroundColor: AppColors.success)
                        );
                        
                        // Optimistically update local state if needed via provider
                        // Use Hive to decrement coins?
                        // For MVP, DatabaseService is source of truth for coins, 
                        // syncing back to Hive on generic sync.
                      } catch (e) {
                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text("Error: $e"))
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Seal the Pact 🤝"),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/user_provider.dart';
import '../../providers/workout_calendar_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/page_routes.dart';
import '../tracking/tracking_provider.dart';
import '../tracking/tracking_screen.dart';
import '../workouts/workout_timer_screen.dart';
import '../journal/journal_provider.dart';
import '../journal/morning_prompt_screen.dart';
import '../journal/journal_screen.dart';
import '../review/progress_timeline_screen.dart';
import '../../providers/partnership_provider.dart';
import '../../providers/health_provider.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../models/squad.dart';
import '../squads/squad_screen.dart';
import '../partnership/find_partner_screen.dart';
import '../../widgets/animated_streak_counter.dart';
import '../pacts/pacts_screen.dart';

final partnerLogsProvider = StreamProvider.family<List<Map<String, dynamic>>, String>((ref, userId) {
  return DatabaseService().streamPartnerLogs(userId);
});

final notificationStreamProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  return DatabaseService().streamNotifications();
});



class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Sweat Pals", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              // Streak Counter
              _buildStreakCard(context, ref),
              const SizedBox(height: 24),
              // Squad Status Card
              _buildSquadStatusCard(context, ref),
              const SizedBox(height: 24),
              // Daily Checklist
              _buildDailyChecklist(context, ref),
              const SizedBox(height: 24),
              // Today's Activity
              _buildActivityCard(context, ref),
              const SizedBox(height: 24),
              // Quick Actions
              _buildQuickActions(context, ref),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildStreakCard(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(trackingProvider.notifier).calculateStreak();
    final user = ref.read(userProvider);
    final tokens = user?.restTokens ?? 0;
    
    // Check if frozen today or completed
    // Note: This logic could be moved to provider but doing here for MVP
    final checkIns = ref.watch(trackingProvider);
    final today = DateTime.now();
    bool isCompletedOrFrozen = false;
    for (var checkIn in checkIns) {
       if (checkIn.date.year == today.year && checkIn.date.month == today.month && checkIn.date.day == today.day) {
         if (checkIn.exerciseCompleted || checkIn.isFrozen) {
           isCompletedOrFrozen = true;
           break;
         }
       }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TrackingScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primaryVariant],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Text('🔥', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$streak day streak',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        streak == 0 ? 'Start today!' : 'Keep it up! 💪',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      if (tokens > 0) ...[
                         const SizedBox(width: 8),
                         Container(
                           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                           decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(4)),
                           child: Text('❄️ $tokens', style: const TextStyle(color: Colors.white, fontSize: 10)),
                         ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (!isCompletedOrFrozen && tokens > 0)
              TextButton(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Freeze Streak? ❄️'),
                      content: Text('Use 1 Rest Token to keep your streak alive today?\nYou have $tokens tokens left.'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                        TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Freeze')),
                      ],
                    ),
                  );
                  
                  if (confirmed == true) {
                    await ref.read(trackingProvider.notifier).freezeToday();
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text('Freeze'),
              )
            else
               const Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildSquadStatusCard(BuildContext context, WidgetRef ref) {
    return StreamBuilder<Map<String, dynamic>?>(
      stream: DatabaseService().streamMySquad(),
      builder: (context, snapshot) {
        final squadData = snapshot.data;
        
        if (squadData == null) {
           return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                Icon(Icons.groups_3_rounded, size: 48, color: AppColors.textSecondary),
                const SizedBox(height: 12),
                const Text(
                  "Flying Solo?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Join a Pack to unlock the chat and map.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SquadScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      "Find a Squad",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const FindPartnerScreen()));
                  },
                  child: Text(
                    "Or find a 1:1 Partner",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final squad = Squad.fromJson(squadData);
        final isWolf = squad.isWolfPack;

        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SquadScreen()));
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isWolf 
                  ? [AppColors.primaryVariant, AppColors.primary] 
                  : [AppColors.primary, AppColors.primary.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      squad.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isWolf ? "WOLF PACK" : "SOCIAL CLUB",
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Tap to view grid, chat & map",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildDailyChecklist(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Goals",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _ChecklistItem(
          icon: Icons.sunny,
          label: "Morning Journal",
          isComplete: false,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MorningPromptScreen())), // Simplified nav
        ),
        _ChecklistItem(
          icon: Icons.fitness_center, 
          label: "Workout",
          isComplete: false, 
          onTap: () {}, // Todo
        ),
      ],
    );
  }

  Widget _buildActivityCard(BuildContext context, WidgetRef ref) {
    final healthState = ref.watch(healthProvider);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCardBackground,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.directions_run, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Daily Activity", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              if (healthState.isLoading)
                const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              else if (!healthState.isConnected)
                 GestureDetector(
                   onTap: () => ref.read(healthProvider.notifier).requestSync(),
                   child: Container(
                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                     decoration: BoxDecoration(
                       color: AppColors.primary,
                       borderRadius: BorderRadius.circular(12),
                     ),
                     child: const Text("Sync", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                   ),
                 ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               _ActivityStat(
                 icon: Icons.do_not_step, 
                 value: healthState.steps.toString(),
                 label: "Steps",
                 color: const Color(0xFF651FFF), // Accent 
               ),
               Container(width: 1, height: 40, color: Colors.white10),
               _ActivityStat(
                 icon: Icons.local_fire_department_rounded, 
                 value: healthState.calories.toString(), 
                 label: "Kcal",
                 color: const Color(0xFFFF9F0A), // Warning/Fire
               ),
            ],
          ),
          if (!healthState.isConnected) ...[
            const SizedBox(height: 16),
            const Text(
              "Connect your device to track steps automagically.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.bolt_rounded, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                icon: Icons.timeline_rounded,
                label: 'View Progress',
                color: AppColors.primary,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressTimelineScreen())),
              ),
            ),
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.notifications_active_rounded,
                  label: 'Send Vibes',
                  color: AppColors.primary,
                  onTap: () => _showSendVibesSheet(context, ref),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
           Row(
            children: [
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.handshake_rounded,
                  label: 'Social Contracts',
                  color: Colors.orange,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PactsScreen())),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(child: SizedBox()), // Spacer
            ],
          ),
          // Listen for incoming nudges
          const _IncomingNudgeListener(),
        ],
      );
  }

  void _showSendVibesSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Send Good Vibes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _VibeOption(emoji: '👋', label: 'Wave', onTap: () => _sendVibe(context, ref, 'wave')),
                _VibeOption(emoji: '🔥', label: 'Fire', onTap: () => _sendVibe(context, ref, 'fire')),
                _VibeOption(emoji: '💪', label: 'Flex', onTap: () => _sendVibe(context, ref, 'flex')),
                _VibeOption(emoji: '😴', label: 'Wake Up', onTap: () => _sendVibe(context, ref, 'wakeup')),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _sendVibe(BuildContext context, WidgetRef ref, String type) async {
    Navigator.pop(context); // Close sheet
    HapticFeedback.mediumImpact();

    final partnership = ref.read(activePartnershipProvider);
    if (partnership != null) {
      final myId = AuthService().currentUserId;
      final p1 = partnership['user_1'] as String;
      final p2 = partnership['user_2'] as String;
      final partnerId = myId == p1 ? p2 : p1;

      try {
        await DatabaseService().sendNudge(partnerId, type: type);
        if (context.mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Vibe sent! $type'),
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to send vibe.')),
          );
        }
      }
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No partner to vibe with yet!')),
      );
    }
  }
}

class _VibeOption extends StatelessWidget {
  final String emoji;
  final String label;
  final VoidCallback onTap;

  const _VibeOption({required this.emoji, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 32)),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// _PartnerStatusWidget removed - replaced by Squad system

class _IncomingNudgeListener extends ConsumerStatefulWidget {
  const _IncomingNudgeListener();

  @override
  ConsumerState<_IncomingNudgeListener> createState() => _IncomingNudgeListenerState();
}

class _IncomingNudgeListenerState extends ConsumerState<_IncomingNudgeListener> {
  DateTime? _lastNudgeTime;

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationStreamProvider);

    ref.listen(notificationStreamProvider, (previous, next) {
      if (next.hasValue && next.value!.isNotEmpty) {
        final latest = next.value!.first;
        final createdAt = DateTime.tryParse(latest['created_at']);
        
        // Ensure it's a new nudge (created after we started listening or last handled)
        // A simple check is "is it within the last 10 seconds?" 
        // Real logic would track the 'seen' state in DB, but for MVP:
        if (createdAt != null && 
            DateTime.now().difference(createdAt).inSeconds < 10 && 
            (_lastNudgeTime == null || createdAt.isAfter(_lastNudgeTime!))) {
              
          _lastNudgeTime = createdAt;
          HapticFeedback.heavyImpact();
          
          final type = latest['type'] as String? ?? 'nudge';
          String message = "Partner says: Hi! 👋";
          String emoji = "👋";
          Color color = AppColors.primary;

          switch (type) {
            case 'fire':
              message = "Partner says: You're on FIRE! 🔥";
              emoji = "🔥";
              color = Colors.orange;
              break;
            case 'flex':
              message = "Partner says: Stay HARD! 💪";
              emoji = "💪";
              color = Colors.green;
              break;
            case 'wakeup':
              message = "Partner says: WAKE UP! 😴";
              emoji = "⏰";
              color = Colors.red;
              break;
            case 'wave':
            default:
              // Default
              break;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(child: Text(message, style: const TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
              backgroundColor: color,
              duration: const Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    });

    return const SizedBox.shrink(); 
  }
}

class _ChecklistItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isComplete;
  final VoidCallback? onTap;

  const _ChecklistItem({
    required this.icon,
    required this.label,
    required this.isComplete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: isComplete ? null : onTap,
        leading: Icon(
          isComplete ? Icons.check_circle_rounded : icon,
          color: isComplete ? Colors.green : AppColors.primary,
        ),
        title: Text(
          label,
          style: TextStyle(
            decoration: isComplete ? TextDecoration.lineThrough : null,
            color: isComplete ? Colors.grey : null,
          ),
        ),
        trailing: isComplete 
            ? const Icon(Icons.done, color: Colors.green)
            : const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}

class _ActivityStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _ActivityStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? color;

  const _QuickStatCard({
    required this.icon,
    required this.value,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: c, size: 28),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: c)),
            Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

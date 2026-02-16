import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'tracking_provider.dart';
import 'daily_check_in_form.dart';
import '../../widgets/animated_streak_counter.dart';
import '../../widgets/animated_widgets.dart';
import '../../widgets/sweat_pal_card.dart';
import '../../services/database_service.dart';
import '../../providers/partnership_provider.dart';
import '../../theme/app_colors.dart';
import '../../providers/user_provider.dart';
import '../ai_coach/ai_chat_screen.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Tracking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            tooltip: 'Talk to Trainer',
            onPressed: () => context.push('/today/tracking/chat'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Me'),
            Tab(text: 'Squad'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _MyTrackingTab(),
          _SquadStatsTab(),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: GlowingFAB(
          onPressed: () => context.push('/today/tracking/checkin'),
          label: 'Check-in',
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}

class _MyTrackingTab extends ConsumerWidget {
  const _MyTrackingTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(trackingProvider);
    final streak = ref.read(trackingProvider.notifier).calculateStreak();

    return Column(
      children: [
        AnimatedStreakCounter(streak: streak, onTap: () {}),
        Expanded(
          child: entries.isEmpty
              ? const Center(child: Text('No check-ins yet. Start today!'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return _EntryCard(entry: entry);
                  },
                ),
        ),
      ],
    );
  }
}

class _SquadStatsTab extends ConsumerWidget {
  const _SquadStatsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partnershipAsync = ref.watch(activePartnershipProvider);

    return partnershipAsync == null
        ? _buildEmptyState(context)
        : _buildPartnerDashboard(context, ref, partnershipAsync);
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text("No Squad yet?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Link up with a friend to see their stats here!", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildPartnerDashboard(BuildContext context, WidgetRef ref, Map<String, dynamic> partnership) {
    // Determine who is the partner
    final myId = ref.watch(userProvider).value?.name ?? ''; // User ID from profile 
    // Ideally userProvider should give ID or we fetch from AuthService.
    // Assuming partnership map has 'user_1' and 'user_2'.
    // We need logic to find "the other ID".
    // For now, let's stream logs and if they aren't ours, they are partner's.
    // Better: Helper in PartnershipService or just use first non-me ID logic if available.
    // Simpler hack: Query the partnership row for the ID that ISNT me.
    
    // For MVP trace, we will just fetch the partner ID from the partnership map.
    // However, we don't have 'currentUserId' easily accessible in build without auth inst.
    // Let's assume the provider handles it or we pass it.
    // Actually, 'activePartnershipProvider' could return a "Partnership" object with "partnerId" pre-calculated.
    // But it returns Map currently.
    
    final partnerId = partnership['user_1'] == 'me' ? partnership['user_2'] : partnership['user_1']; // Placeholder logic
    // Real logic requires AuthService.currentUserId
    
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref.watch(databaseServiceProvider).streamPartnerCheckIns(partnerId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        
        final logs = snapshot.data!;
        if (logs.isEmpty) return const Center(child: Text("Partner hasn't logged anything yet."));

        final todayLog = logs.first; // Assuming order desc
        
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text("Partner's Today", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            _buildStatCard(
              context, 
              "Mood", 
              '⭐' * (todayLog['mood_score'] ?? 3), 
              Icons.sentiment_satisfied_alt,
              Colors.orange
            ),
            const SizedBox(height: 12),
            _buildStatCard(
              context, 
              "Energy", 
              "${todayLog['energy_level'] ?? 0}/10", 
              Icons.bolt,
              Colors.blue
            ),
             const SizedBox(height: 12),
            _buildStatCard(
              context, 
              "Worked Out?", 
              (todayLog['exercise_completed'] ?? false) ? "YES! 🔥" : "Not yet 💤", 
              Icons.fitness_center,
              (todayLog['exercise_completed'] ?? false) ? Colors.green : Colors.grey
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  final dynamic entry; // DailyCheckIn
  const _EntryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    // Map dynamic entry to typed if possible or use dynamic access
    // entry is likely DailyCheckIn object from Hive
    
    // Convert water bool to int check for safety if model changed
    final waterDisplay = entry.waterIntake is int ? '${entry.waterIntake}ml' : (entry.waterIntake == true ? 'Yes' : 'No');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SweatPalCard(
        padding: EdgeInsets.zero,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              DateFormat('EEEE, MMM d').format(entry.date),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                _buildSmallTag(context, entry.exerciseCompleted ? 'Exercise' : 'Rest', entry.exerciseCompleted),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sleep: ${entry.sleepHours}h'),
                        Text('Mood: ${'⭐' * entry.moodScore}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallTag(BuildContext context, String text, bool success) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: success ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: success ? Colors.green : Colors.red, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: success ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}

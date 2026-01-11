import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/user_provider.dart';
import '../../providers/avatar_provider.dart';
import '../../theme/app_colors.dart';
import '../tracking/tracking_provider.dart';
import '../dashboard/photos_provider.dart';
import 'review_provider.dart';

class ProgressTimelineScreen extends ConsumerWidget {
  const ProgressTimelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final photos = ref.watch(photosProvider);
    final reviews = ref.watch(reviewProvider);
    final avatarState = ref.watch(avatarProvider);
    final streak = ref.watch(trackingProvider.notifier).calculateStreak();
    
    // Calculate journey duration
    final firstReview = reviews.isNotEmpty ? reviews.last : null;
    final daysSinceStart = firstReview != null 
        ? DateTime.now().difference(firstReview.date).inDays 
        : 0;
    
    // Calculate weight change
    final startWeight = firstReview?.weight ?? user?.startingWeight ?? 0;
    final currentWeight = reviews.isNotEmpty ? reviews.first.weight : startWeight;
    final weightChange = currentWeight - startWeight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Journey'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Journey Summary Card
            _buildJourneySummaryCard(context, daysSinceStart, weightChange, streak, avatarState.level),
            const SizedBox(height: 24),
            
            // Day 1 vs Now Comparison
            if (photos.length >= 2) ...[
              _buildSectionHeader(context, 'Transformation'),
              const SizedBox(height: 12),
              _buildComparisonCard(context, photos),
              const SizedBox(height: 24),
            ],
            
            // Timeline
            _buildSectionHeader(context, 'Your Timeline'),
            const SizedBox(height: 12),
            _buildTimeline(context, ref, photos, reviews),
          ],
        ),
      ),
    );
  }

  Widget _buildJourneySummaryCard(BuildContext context, int days, double weightChange, int streak, int level) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.emoji_events, color: Colors.amber, size: 48),
          const SizedBox(height: 12),
          Text(
            'Day $days of Your Journey',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryMetric(
                weightChange >= 0 ? '+${weightChange.toStringAsFixed(1)}' : weightChange.toStringAsFixed(1),
                'lbs',
                weightChange > 0 ? Icons.trending_up : Icons.trending_down,
              ),
              Container(width: 1, height: 40, color: Colors.white.withValues(alpha: 0.3)),
              _buildSummaryMetric('$streak', 'day streak', Icons.local_fire_department),
              Container(width: 1, height: 40, color: Colors.white.withValues(alpha: 0.3)),
              _buildSummaryMetric('Lv $level', 'avatar', Icons.star),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryMetric(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildComparisonCard(BuildContext context, List<dynamic> photos) {
    final firstPhoto = photos.last; // Oldest photo
    final latestPhoto = photos.first; // Newest photo

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
            child: _buildComparisonHalf(
              context,
              'Day 1',
              firstPhoto.imagePath,
              firstPhoto.date,
            ),
          ),
          Container(width: 2, color: Colors.white),
          Expanded(
            child: _buildComparisonHalf(
              context,
              'Today',
              latestPhoto.imagePath,
              latestPhoto.date,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonHalf(BuildContext context, String label, String imagePath, DateTime date) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 0.75,
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              DateFormat('MMM d').format(date),
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline(BuildContext context, WidgetRef ref, List<dynamic> photos, List<dynamic> reviews) {
    // Combine and sort events
    final events = <_TimelineEvent>[];
    
    for (final photo in photos) {
      events.add(_TimelineEvent(
        date: photo.date,
        type: _EventType.photo,
        title: 'Progress Photo',
        subtitle: 'Added a check-in photo',
        imagePath: photo.imagePath,
      ));
    }
    
    for (final review in reviews) {
      events.add(_TimelineEvent(
        date: review.date,
        type: _EventType.weight,
        title: 'Weight Check-in',
        subtitle: '${review.weight} lbs',
      ));
    }
    
    // Add milestones
    if (events.isNotEmpty) {
      final firstEvent = events.reduce((a, b) => a.date.isBefore(b.date) ? a : b);
      events.add(_TimelineEvent(
        date: firstEvent.date,
        type: _EventType.milestone,
        title: 'Journey Started! 🚀',
        subtitle: 'You took the first step',
      ));
    }
    
    // Sort by date descending (newest first)
    events.sort((a, b) => b.date.compareTo(a.date));

    if (events.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.timeline, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Your timeline will appear here',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Log your weight and add photos to track progress',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: events.asMap().entries.map((entry) {
        final index = entry.key;
        final event = entry.value;
        final isLast = index == events.length - 1;
        
        return _buildTimelineItem(context, event, isLast);
      }).toList(),
    );
  }

  Widget _buildTimelineItem(BuildContext context, _TimelineEvent event, bool isLast) {
    final color = switch (event.type) {
      _EventType.photo => Colors.blue,
      _EventType.weight => AppColors.primary,
      _EventType.milestone => Colors.amber,
      _EventType.workout => Colors.green,
    };

    final icon = switch (event.type) {
      _EventType.photo => Icons.camera_alt,
      _EventType.weight => Icons.monitor_weight,
      _EventType.milestone => Icons.emoji_events,
      _EventType.workout => Icons.fitness_center,
    };

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line and dot
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Colors.grey[300],
                    ),
                  ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: color, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            event.subtitle,
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      DateFormat('MMM d').format(event.date),
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _EventType { photo, weight, milestone, workout }

class _TimelineEvent {
  final DateTime date;
  final _EventType type;
  final String title;
  final String subtitle;
  final String? imagePath;

  _TimelineEvent({
    required this.date,
    required this.type,
    required this.title,
    required this.subtitle,
    this.imagePath,
  });
}

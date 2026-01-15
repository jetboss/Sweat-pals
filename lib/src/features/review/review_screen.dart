import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'review_provider.dart';
import 'weekly_review_form.dart';
import '../../utils/page_routes.dart';
import '../../widgets/animated_widgets.dart';
import '../../theme/app_colors.dart';

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(reviewProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Weekly Progress')),
      body: reviews.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bar_chart_rounded, size: 64, color: AppColors.textSecondary),
                  const SizedBox(height: 16),
                  const Text('No reviews yet. Time for your first one, pal?'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.pushAnimated(const WeeklyReviewForm()),
                    child: const Text('Start Weekly Review'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildChartCard(context, reviews),
                  const SizedBox(height: 24),
                  Text('Review History', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...reviews.map((review) => _buildReviewItem(context, review)),
                ],
              ),
            ),
      floatingActionButton: reviews.isNotEmpty
          ? GlowingFAB(
              onPressed: () => context.pushAnimated(const WeeklyReviewForm()),
              child: const Icon(Icons.add_rounded),
            )
          : null,
    );
  }

  Widget _buildChartCard(BuildContext context, List<dynamic> reviews) {
    // Show only last 7 reviews for the chart
    final displayReviews = reviews.take(7).toList().reversed.toList();
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Weight Trend', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: displayReviews.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value.weight);
                      }).toList(),
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 4,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, dynamic review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(DateFormat('MMM d, yyyy').format(review.date)),
        subtitle: Text('Weight: ${review.weight} | Waist: ${review.waist} | Score: ${review.consistencyScore}/10'),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () {
          // Show details if needed, but suggestion is the main thing
          showModalBottomSheet(
            context: context,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Weekly Reflection', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  Text('Notes: ${review.notes.isEmpty ? "None" : review.notes}'),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text('Way to go, Pal!', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

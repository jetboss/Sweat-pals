import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/user_provider.dart';
import '../../providers/theme_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/motivational_quote_card.dart';
import '../../utils/page_routes.dart';
import '../tracking/tracking_provider.dart';
import '../review/review_provider.dart';
import 'photos_provider.dart';
import '../meals/meals_screen.dart';
import '../workouts/workouts_screen.dart';
import '../tracking/tracking_screen.dart';
import '../journal/journal_screen.dart';
import '../support/support_screen.dart';
import '../review/review_screen.dart';
import '../workouts/workout_calendar_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  /// Resets all app data and returns to onboarding
  static Future<void> _resetApp(BuildContext context, WidgetRef ref) async {
    // Clear all Hive boxes
    await Hive.deleteFromDisk();
    
    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    // Navigate to fresh start (restart app)
    if (context.mounted) {
      // Exit and restart - user will see onboarding on next launch
      Navigator.of(context).popUntil((route) => route.isFirst);
      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('App reset! Please restart the app to see onboarding.'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final userName = user?.name ?? 'Sweat Pal';
    final streak = ref.watch(trackingProvider.notifier).calculateStreak();
    final reviews = ref.watch(reviewProvider);
    final photos = ref.watch(photosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sweat Pals'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
            tooltip: 'Toggle Dark Mode',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings_rounded),
            tooltip: 'Settings',
            onSelected: (value) async {
              if (value == 'reset') {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Reset App?'),
                    content: const Text('This will delete all your data and return to onboarding. This cannot be undone!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        style: TextButton.styleFrom(foregroundColor: Colors.red),
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                );
                if (confirm == true && context.mounted) {
                  await _resetApp(context, ref);
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'reset',
                child: Row(
                  children: [
                    Icon(Icons.restart_alt_rounded, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Reset App', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeHeader(context, userName),
            const SizedBox(height: 24),
            const MotivationalQuoteCard(),
            const SizedBox(height: 24),
            _buildStatGrid(context, streak, user),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Weight Trend', onSeeAll: () {
               context.pushAnimated(const ReviewScreen());
            }),
            const SizedBox(height: 12),
            _buildMiniChart(context, reviews),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Progress Photos', onSeeAll: () {}),
            const SizedBox(height: 12),
            _buildPhotosList(context, ref, photos),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Quick Links'),
            const SizedBox(height: 12),
            _buildQuickLinksGrid(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi $name!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.pink[300],
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Ready to crush it today, pal?',
          style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildStatGrid(BuildContext context, int streak, dynamic user) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.local_fire_department_rounded,
            label: 'Streak',
            value: '$streak Days',
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            icon: Icons.restaurant_rounded,
            label: 'Goal',
            value: '${user?.tdee.toStringAsFixed(0) ?? "2,000"} Cal',
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: const Text('See All'),
          ),
      ],
    );
  }

  Widget _buildMiniChart(BuildContext context, List<dynamic> reviews) {
    if (reviews.isEmpty) {
      return const _EmptyCard(message: 'Log your first weekly review to see trends!');
    }

    final displayReviews = reviews.take(5).toList().reversed.toList();
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(20),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: displayReviews.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.weight)).toList(),
                isCurved: true,
                color: Theme.of(context).colorScheme.primary,
                barWidth: 4,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: true, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotosList(BuildContext context, WidgetRef ref, List<dynamic> photos) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _AddPhotoButton(onTap: () => _showPhotoPickerOptions(context, ref));
          }
          final photo = photos[index - 1];
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[200],
              image: DecorationImage(
                image: FileImage(File(photo.imagePath)),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPhotoPickerOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Progress Photo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _PhotoOption(
                    icon: Icons.camera_alt_rounded,
                    label: 'Camera',
                    onTap: () {
                      Navigator.pop(context);
                      ref.read(photosProvider.notifier).pickAndAddPhoto(ImageSource.camera);
                    },
                  ),
                  _PhotoOption(
                    icon: Icons.photo_library_rounded,
                    label: 'Gallery',
                    onTap: () {
                      Navigator.pop(context);
                      ref.read(photosProvider.notifier).pickAndAddPhoto(ImageSource.gallery);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickLinksGrid(BuildContext context) {
    final links = [
      _QuickLink(Icons.restaurant_rounded, 'Meals', Colors.orange, const MealsScreen()),
      _QuickLink(Icons.fitness_center_rounded, 'Workouts', Colors.blue, const WorkoutsScreen()),
      _QuickLink(Icons.calendar_month_rounded, 'Calendar', Colors.pink, const WorkoutCalendarScreen()),
      _QuickLink(Icons.show_chart_rounded, 'Tracking', Colors.green, const TrackingScreen()),
      _QuickLink(Icons.book_rounded, 'Journal', Colors.purple, const JournalScreen()),
      _QuickLink(Icons.favorite_rounded, 'Support', Colors.red, const SupportScreen()),
      _QuickLink(Icons.bar_chart_rounded, 'Review', Colors.teal, const ReviewScreen()),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: links.length,
      itemBuilder: (context, index) {
        final link = links[index];
        return InkWell(
          onTap: () => context.pushAnimated(link.screen),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: link.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: link.color.withValues(alpha: 0.2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(link.icon, color: link.color),
                const SizedBox(height: 8),
                Text(link.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: link.color)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: color.withValues(alpha: 0.7))),
              Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddPhotoButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddPhotoButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!, width: 2, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add_a_photo_outlined, color: Colors.grey),
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final String message;
  const _EmptyCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
    );
  }
}

class _PhotoOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PhotoOption({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.pink, size: 32),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _QuickLink {
  final IconData icon;
  final String label;
  final Color color;
  final Widget screen;
  _QuickLink(this.icon, this.label, this.color, this.screen);
}

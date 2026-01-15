import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/user_provider.dart';
import 'providers/theme_provider.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/workouts/workouts_screen.dart';
import 'features/tracking/tracking_screen.dart';
import 'features/today/today_screen.dart';
import 'features/workouts/workout_calendar_screen.dart';
import 'features/profile/profile_screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = ref.watch(initializationProvider);
    final isOnboardingComplete = ref.watch(onboardingCompleteProvider);
    final user = ref.watch(userProvider);
    final themeMode = ref.watch(themeModeProvider);

    if (!isInitialized) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'Sweat Pals',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: (user == null && !isOnboardingComplete) 
          ? const OnboardingScreen() 
          : const MainShell(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const TodayScreen(),
    const WorkoutCalendarScreen(),
    const WorkoutsScreen(),
    const TrackingScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Crucial for content behind nav bar
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 32, right: 32, bottom: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor?.withValues(alpha: 0.8) ?? Colors.white.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(0, Icons.wb_sunny_outlined, Icons.wb_sunny_rounded),
                  _buildNavItem(1, Icons.calendar_month_outlined, Icons.calendar_month_rounded),
                  _buildNavItem(2, Icons.fitness_center_outlined, Icons.fitness_center_rounded),
                  _buildNavItem(3, Icons.show_chart_rounded, Icons.insights_rounded),
                  _buildNavItem(4, Icons.person_outline, Icons.person_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Icon(
          isSelected ? activeIcon : icon,
          size: 24,
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
        ),
      ),
    );
  }
}

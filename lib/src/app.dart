import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/user_provider.dart';
import 'providers/theme_provider.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/meals/meals_screen.dart';
import 'features/workouts/workouts_screen.dart';
import 'features/tracking/tracking_screen.dart';
import 'features/today/today_screen.dart';
import 'features/workouts/workout_calendar_screen.dart';

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
    const MealsScreen(),
    const TrackingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Crucial for content behind nav bar
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
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
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (index) => setState(() => _selectedIndex = index),
                backgroundColor: Colors.transparent, // Important
                elevation: 0, // Remove shadow
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: false, // Cleaner look
                showUnselectedLabels: false,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.wb_sunny_outlined), 
                    activeIcon: Icon(Icons.wb_sunny_rounded),
                    label: 'Today'
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month_outlined), 
                    activeIcon: Icon(Icons.calendar_month_rounded),
                    label: 'Calendar'
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.fitness_center_outlined), 
                    activeIcon: Icon(Icons.fitness_center_rounded),
                    label: 'Workouts'
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.restaurant_outlined), 
                    activeIcon: Icon(Icons.restaurant_rounded),
                    label: 'Meals'
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.show_chart_rounded), 
                    activeIcon: Icon(Icons.insights_rounded),
                    label: 'Tracking'
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

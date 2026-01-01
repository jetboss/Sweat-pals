import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/user_provider.dart';
import 'providers/theme_provider.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/meals/meals_screen.dart';
import 'features/workouts/workouts_screen.dart';
import 'features/tracking/tracking_screen.dart';
import 'features/journal/journal_screen.dart';

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
    const DashboardScreen(),
    const MealsScreen(),
    const WorkoutsScreen(),
    const TrackingScreen(),
    const JournalScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_rounded), label: 'Meals'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center_rounded), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart_rounded), label: 'Tracking'),
          BottomNavigationBarItem(icon: Icon(Icons.book_rounded), label: 'Journal'),
        ],
      ),
    );
  }
}

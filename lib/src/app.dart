import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/user_provider.dart';
import 'providers/theme_provider.dart';
import 'router/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = ref.watch(initializationProvider);
    final onboardingAsync = ref.watch(onboardingCompleteProvider);
    final user = ref.watch(userProvider);
    final themeMode = ref.watch(themeModeProvider);

    if (!isInitialized || onboardingAsync.isLoading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    final isOnboardingComplete = onboardingAsync.value ?? false;

    // Use GoRouter
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Sweat Pals',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}




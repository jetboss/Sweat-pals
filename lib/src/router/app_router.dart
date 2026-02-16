import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/today/today_screen.dart';
import '../features/workouts/workout_calendar_screen.dart';
import '../features/workouts/workouts_screen.dart';
import '../features/workouts/create_workout_screen.dart';
import '../features/workouts/workout_timer_screen.dart';
import '../features/pacts/pacts_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/squads/create_squad_screen.dart';
import '../features/squads/squad_screen.dart';
import '../features/partnership/find_partner_screen.dart';
import '../features/journal/morning_prompt_screen.dart';
import '../features/review/progress_timeline_screen.dart';
import '../features/tracking/tracking_screen.dart';
import '../features/tracking/daily_check_in_form.dart';
import '../features/ai_coach/ai_chat_screen.dart';
import '../features/review/weekly_review_form.dart';

import '../widgets/scaffold_with_nav_bar.dart';
import '../providers/user_provider.dart';
import '../models/workout.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final onboardingAsync = ref.watch(onboardingCompleteProvider);
  final isOnboardingComplete = onboardingAsync.value ?? false;
  final user = ref.watch(userProvider);
  
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: isOnboardingComplete ? '/today' : '/onboarding',
    
    // Simple redirect logic
    redirect: (context, state) {
      // If loading onboarding state, maybe show splash? Handled by App.dart currently.
      // Here we assume if provider emits, we are ready.
      
      final isLoggingIn = state.uri.toString() == '/login';
      final isOnboarding = state.uri.toString() == '/onboarding';
      
      // If not finished onboarding, force onboarding
      if (!isOnboardingComplete && !isLoggingIn && !isOnboarding) {
        return '/onboarding';
      }
      
      // If finished onboarding but on onboarding page, go home
      if (isOnboardingComplete && isOnboarding) {
        return '/today';
      }
      
      return null;
    },
    
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      
      // Main App Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // 0: Today
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/today',
                builder: (context, state) => const TodayScreen(),
                routes: [
                   GoRoute(
                    path: 'morning-prompt',
                    builder: (context, state) => const MorningPromptScreen(),
                  ),
                   GoRoute(
                    path: 'find-partner',
                    builder: (context, state) => const FindPartnerScreen(),
                  ),
                  GoRoute(
                    path: 'tracking',
                    builder: (context, state) => const TrackingScreen(),
                    routes: [
                      GoRoute(
                        path: 'checkin',
                        builder: (context, state) => const DailyCheckInForm(),
                      ),
                      GoRoute(
                        path: 'chat',
                        builder: (context, state) => const AiChatScreen(),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'timeline',
                    builder: (context, state) => const ProgressTimelineScreen(),
                  ),
                   GoRoute(
                    path: 'weekly-review',
                    builder: (context, state) => const WeeklyReviewForm(),
                  ),
                ],
              ),
            ],
          ),
          
          // 1: Calendar
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calendar',
                builder: (context, state) => const WorkoutCalendarScreen(),
              ),
            ],
          ),
          
          // 2: Workouts
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/workouts',
                builder: (context, state) => const WorkoutsScreen(),
                routes: [
                  GoRoute(
                    path: 'new',
                    builder: (context, state) => const CreateWorkoutScreen(),
                  ),
                ],
              ),
            ],
          ),
          
          // 3: Pacts
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pacts',
                builder: (context, state) => const PactsScreen(),
              ),
            ],
          ),
          
          // 4: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      
      // Full screen / Common Routes (Not nested in shell if we want to hide bottom bar, 
      // OR nested if we want to keep it.
      // Usually Timer hides bottom bar -> Root navigator)
      
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/workout/timer',
        builder: (context, state) {
          final workout = state.extra as Workout;
          return WorkoutTimerScreen(workout: workout);
        },
      ),

      GoRoute(
         parentNavigatorKey: _rootNavigatorKey,
         path: '/squad/create',
         builder: (context, state) => const CreateSquadScreen(),
      ),

      GoRoute(
         parentNavigatorKey: _rootNavigatorKey, // Hides bottom bar? Often yes for detailed views
         path: '/squad',
         builder: (context, state) => const SquadScreen(),
      ),

      // Legacy/Other routes
      // ProgressTimelineScreen
      // Verify if file exists first. Assuming yes based on analysis.
    ],
  );
});

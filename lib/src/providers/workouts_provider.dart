import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/workout.dart';

final workoutsProvider = StateNotifierProvider<WorkoutsNotifier, List<Workout>>((ref) {
  return WorkoutsNotifier();
});

class WorkoutsNotifier extends StateNotifier<List<Workout>> {
  WorkoutsNotifier() : super([]) {
    _loadWorkouts();
  }

  void _loadWorkouts() {
    state = [
      _createStrengthDay(),
      _createFatLossDay(),
      _createMobilityDay(),
      _createFullBodyDay(),
    ];
  }

  Workout _createStrengthDay() {
    return const Workout(
      id: 'strength_1',
      title: 'Power Pal Strength',
      description: 'Building foundations with bodyweight basics.',
      category: 'Strength',
      imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=400',
      exercises: [
        Exercise(
          name: 'Push-ups', 
          reps: 12, 
          instructions: 'Keep your core tight and elbows at 45 degrees.',
          imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=400',
          // videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4', -- To be replaced with hosted asset
        ),
        Exercise(
          name: 'Bodyweight Squats', 
          reps: 20, 
          instructions: 'Chest up, weight on heels.',
          imageUrl: 'https://images.unsplash.com/photo-1574680077505-ef74a5ea946d?q=80&w=400',
        ),
        Exercise(
          name: 'Plank', 
          durationSeconds: 60, 
          instructions: 'Strict line from head to heels.',
          imageUrl: 'https://images.unsplash.com/photo-1517821063934-8bd194b07c26?q=80&w=400',
        ),
        Exercise(
          name: 'Lunges', 
          reps: 10, 
          instructions: 'Step forward and drop knee to 90 degrees.',
          imageUrl: 'https://images.unsplash.com/photo-1434596922112-19c563067271?q=80&w=400',
        ),
      ],
    );
  }

  Workout _createFatLossDay() {
    return const Workout(
      id: 'fatloss_1',
      title: 'Sweat Buddy HIIT',
      description: 'High intensity to burn fat together!',
      category: 'Fat Loss',
      imageUrl: 'https://images.unsplash.com/photo-1541534741688-6078c6bc1590?q=80&w=400',
      exercises: [
        Exercise(
          name: 'Jumping Jacks', 
          durationSeconds: 45, 
          instructions: 'Fast arms and legs.',
          imageUrl: 'https://images.unsplash.com/photo-1599058945522-28d584b6f0ff?q=80&w=400',
        ),
        Exercise(
          name: 'Mountain Climbers', 
          durationSeconds: 45, 
          instructions: 'Run your knees to chest in plank.',
          imageUrl: 'https://images.unsplash.com/photo-1599058917233-27826233d027?q=80&w=400',
        ),
        Exercise(
          name: 'Burpees', 
          reps: 10, 
          instructions: 'Chest to floor, then jump up!',
          imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=400', // Intense movement
        ),
        Exercise(
          name: 'High Knees', 
          durationSeconds: 45, 
          instructions: 'Knees up to waist level.',
          imageUrl: 'https://images.unsplash.com/photo-1552674605-4695c52c676c?q=80&w=400', // Runner/Cardio
        ),
      ],
    );
  }

  Workout _createMobilityDay() {
    return const Workout(
      id: 'mobility_1',
      title: 'Flexy Pal Flow',
      description: 'Improving range of motion and recovery.',
      category: 'Mobility',
      imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=400',
      exercises: [
        Exercise(
          name: 'Cat-Cow', 
          durationSeconds: 60, 
          instructions: 'Slowly arch and round your back.',
          imageUrl: 'https://images.unsplash.com/photo-1507120416800-bccf17f4587c?q=80&w=400', // Yoga flow
        ),
        Exercise(
          name: 'Downward Dog', 
          durationSeconds: 60, 
          instructions: 'Push through your palms, hips to sky.',
          imageUrl: 'https://images.unsplash.com/photo-1588286840104-44e235a96db9?q=80&w=400', // Downward dog specific
        ),
        Exercise(
          name: 'Child\'s Pose', 
          durationSeconds: 60, 
          instructions: 'Rest your forehead, reach long with arms.',
          imageUrl: 'https://images.unsplash.com/photo-1552196563-55cd4e45efb3?q=80&w=400', // Resting pose
        ),
        Exercise(
          name: 'Cobra Stretch', 
          durationSeconds: 60, 
          instructions: 'Hips down, chest up, look forward.',
          imageUrl: 'https://images.unsplash.com/photo-1575052814086-f385e2e2ad1b?q=80&w=400', // Cobra/Upward dog
        ),
      ],
    );
  }

  Workout _createFullBodyDay() {
    return const Workout(
      id: 'fullbody_1',
      title: 'Ultimate Pal Challenge',
      description: 'Strength + Cardio mashup!',
      category: 'Strength',
      imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=400',
      exercises: [
        Exercise(
          name: 'Diamond Push-ups', 
          reps: 10, 
          instructions: 'Hands formed in a diamond under chest.',
          imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=400', // Pushup var
        ),
        Exercise(
          name: 'Jump Squats', 
          reps: 15, 
          instructions: 'Explode up from the bottom.',
          imageUrl: 'https://images.unsplash.com/photo-1574680077505-ef74a5ea946d?q=80&w=400', // Squat var
        ),
        Exercise(
          name: 'V-Sits', 
          reps: 12, 
          instructions: 'Touch toes and fingers in a V shape.',
          imageUrl: 'https://images.unsplash.com/photo-1517821063934-8bd194b07c26?q=80&w=400', // Abs/Core
        ),
        Exercise(
          name: 'Bird Dog', 
          reps: 16, 
          instructions: 'Opposite arm and leg extension.',
          imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=400', // Stability
        ),
      ],
    );
  }

  Future<void> saveSession(WorkoutSession session) async {
    final box = Hive.box<WorkoutSession>('workout_sessions');
    await box.add(session);
  }

  List<WorkoutSession> getHistory() {
    final box = Hive.box<WorkoutSession>('workout_sessions');
    return box.values.toList().reversed.toList();
  }
}

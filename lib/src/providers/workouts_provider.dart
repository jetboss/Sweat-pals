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
    List<Workout> customWorkouts = [];
    if (Hive.isBoxOpen('custom_workouts')) {
      customWorkouts = Hive.box<Workout>('custom_workouts').values.toList();
    }

    state = [
      // ========== CUSTOM WORKOUTS ==========
      ...customWorkouts,
      // ========== BEGINNER WORKOUTS (7) ==========
      ..._beginnerWorkouts(),
      // ========== KNEE-FRIENDLY WORKOUTS (3) ==========
      ..._kneeFriendlyWorkouts(),
      // ========== INTERMEDIATE WORKOUTS (7) ==========
      ..._intermediateWorkouts(),
      // ========== ADVANCED WORKOUTS (7) ==========
      ..._advancedWorkouts(),
    ];
  }

  Future<void> saveCustomWorkout(Workout workout) async {
    final box = Hive.box<Workout>('custom_workouts');
    await box.put(workout.id, workout);
    _loadWorkouts();
  }

  Future<void> deleteCustomWorkout(String id) async {
    final box = Hive.box<Workout>('custom_workouts');
    await box.delete(id);
    _loadWorkouts();
  }

  // ====== KNEE-FRIENDLY WORKOUTS ======
  List<Workout> _kneeFriendlyWorkouts() => [
    // KF1: Gentle Strength (Beginner, 15 min)
    const Workout(
      id: 'KF1',
      title: 'Gentle Strength',
      description: 'Build strength without stressing your knees. Perfect for beginners or recovery days.',
      category: 'Low Impact',
      level: WorkoutLevel.beginner,
      durationMinutes: 15,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.lowImpact,
      unlockRequirement: 0,
      imageUrl: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=400',
      exercises: [
        Exercise(name: 'Seated Marches', durationSeconds: 60, instructions: 'Sit tall, alternate lifting knees. Keep core engaged.', isLowImpact: true),
        Exercise(name: 'Chair Stand', reps: 10, instructions: 'Stand up from chair without using hands, sit back slowly.', isLowImpact: true),
        Exercise(name: 'Glute Bridges', reps: 12, instructions: 'Lie on back, lift hips, squeeze glutes at top.', isLowImpact: true),
        Exercise(name: 'Wall Sit', durationSeconds: 30, instructions: 'Back against wall, thighs parallel. Hold steady.', isLowImpact: true),
        Exercise(name: 'Seated Leg Raises', reps: 10, instructions: 'Sit tall, extend one leg straight, hold 2 seconds. Each leg.', isLowImpact: true),
        Exercise(name: 'Ankle Circles', durationSeconds: 30, instructions: 'Rotate each ankle slowly. Both directions.', isLowImpact: true),
      ],
    ),

    // KF2: Floor Flow (Beginner, 20 min)
    const Workout(
      id: 'KF2',
      title: 'Floor Flow',
      description: 'Mobility and strength from the ground. Zero standing, zero knee stress.',
      category: 'Low Impact',
      level: WorkoutLevel.beginner,
      durationMinutes: 20,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.lowImpact,
      unlockRequirement: 0,
      imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
      exercises: [
        Exercise(name: 'Ankle Circles', durationSeconds: 30, instructions: 'Warm up ankles. 10 each direction per foot.', isLowImpact: true),
        Exercise(name: 'Dead Bug', reps: 10, instructions: 'On back, extend opposite arm and leg. Core tight.', isLowImpact: true),
        Exercise(name: 'Clamshells', reps: 12, instructions: 'Side-lying, knees bent. Lift top knee, keep feet together.', isLowImpact: true),
        Exercise(name: 'Glute Bridges', reps: 15, instructions: 'Squeeze glutes hard at top. Pause 1 second.', isLowImpact: true),
        Exercise(name: 'Bird Dog', reps: 10, instructions: 'All fours. Extend opposite arm and leg. Hold 2 seconds.', isLowImpact: true),
        Exercise(name: 'Lying Leg Lifts', reps: 10, instructions: 'On back, legs straight. Lift both legs slowly, lower with control.', isLowImpact: true),
        Exercise(name: 'Cat-Cow Stretch', durationSeconds: 45, instructions: 'Flow between arching and rounding back. Breathe deeply.', isLowImpact: true),
      ],
    ),

    // KF3: Chair Cardio (Intermediate, 25 min)
    const Workout(
      id: 'KF3',
      title: 'Chair Cardio',
      description: 'Get your heart pumping without leaving your chair. Great for bad knee days.',
      category: 'Low Impact',
      level: WorkoutLevel.intermediate,
      durationMinutes: 25,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.lowImpact,
      unlockRequirement: 0,
      imageUrl: 'https://images.unsplash.com/photo-1541534741688-6078c6bc1590?w=400',
      exercises: [
        Exercise(name: 'Seated Marches', durationSeconds: 120, instructions: 'Fast pace! Pump those arms.', isLowImpact: true),
        Exercise(name: 'Chair Stand', reps: 15, instructions: 'Control up, control down. No hands!', isLowImpact: true),
        Exercise(name: 'Seated Leg Raises', reps: 15, instructions: 'Alternate legs. Keep core tight.', isLowImpact: true),
        Exercise(name: 'Seated Punches', durationSeconds: 60, instructions: 'Alternate punches. Fast and controlled.', isLowImpact: true),
        Exercise(name: 'Rest', durationSeconds: 30, instructions: 'Shake it out. Breathe.', isLowImpact: true),
        Exercise(name: 'Seated Marches', durationSeconds: 120, instructions: 'Round 2! Push the pace.', isLowImpact: true),
        Exercise(name: 'Chair Stand', reps: 15, instructions: 'Second set. Feel the burn!', isLowImpact: true),
        Exercise(name: 'Seated Leg Raises', reps: 15, instructions: 'Last set. Finish strong!', isLowImpact: true),
        Exercise(name: 'Cool Down Stretch', durationSeconds: 60, instructions: 'Light stretching. Well done!', isLowImpact: true),
      ],
    ),
  ];

  // ====== BEGINNER WORKOUTS ======
  List<Workout> _beginnerWorkouts() => [
    // B1: Morning Wake-Up (Full Body, 10 min)
    const Workout(
      id: 'B1',
      title: 'Morning Wake-Up',
      description: 'A gentle full body routine to start your day right.',
      category: 'Full Body',
      level: WorkoutLevel.beginner,
      durationMinutes: 10,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.fullBody,
      unlockRequirement: 0,
      imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
      exercises: [
        Exercise(name: 'Arm Circles', durationSeconds: 30, instructions: 'Rotate arms in small circles, forward then backward.'),
        Exercise(name: 'Bodyweight Squats', reps: 10, instructions: 'Chest up, weight on heels, squat to parallel.'),
        Exercise(name: 'Knee Push-ups', reps: 8, instructions: 'Keep core tight, lower chest to floor.'),
        Exercise(name: 'Standing Side Stretch', durationSeconds: 30, instructions: 'Reach overhead and lean side to side.'),
        Exercise(name: 'Marching in Place', durationSeconds: 45, instructions: 'Lift knees high, pump arms.'),
        Exercise(name: 'Cat-Cow Stretch', durationSeconds: 45, instructions: 'On all fours, arch and round your back slowly.'),
      ],
    ),

    // B2: Core Foundations (Core, 10 min)
    const Workout(
      id: 'B2',
      title: 'Core Foundations',
      description: 'Build abdominal strength with beginner-friendly moves.',
      category: 'Core',
      level: WorkoutLevel.beginner,
      durationMinutes: 10,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.core,
      unlockRequirement: 0,
      imageUrl: 'https://images.unsplash.com/photo-1517821063934-8bd194b07c26?w=400',
      exercises: [
        Exercise(name: 'Dead Bug', reps: 10, instructions: 'On back, extend opposite arm and leg while keeping core braced.'),
        Exercise(name: 'Plank Hold', durationSeconds: 20, instructions: 'Forearms on ground, body in straight line.'),
        Exercise(name: 'Glute Bridges', reps: 12, instructions: 'Squeeze glutes at top, hold for 1 second.'),
        Exercise(name: 'Bird Dog', reps: 8, instructions: 'Opposite arm and leg extension on all fours.'),
        Exercise(name: 'Plank Hold', durationSeconds: 20, instructions: 'Forearms on ground, body in straight line.'),
        Exercise(name: 'Lying Leg Raises', reps: 10, instructions: 'Keep legs straight, lower slowly.'),
      ],
    ),

    // B3: Lower Body Basics (Lower, 15 min)
    const Workout(
      id: 'B3',
      title: 'Lower Body Basics',
      description: 'Strengthen your legs and glutes with foundational moves.',
      category: 'Lower Body',
      level: WorkoutLevel.beginner,
      durationMinutes: 15,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.lower,
      unlockRequirement: 0,
      imageUrl: 'https://images.unsplash.com/photo-1574680077505-ef74a5ea946d?w=400',
      exercises: [
        Exercise(name: 'Bodyweight Squats', reps: 15, instructions: 'Chest up, sit back into heels.'),
        Exercise(name: 'Forward Lunges', reps: 10, instructions: 'Step forward, drop back knee to 90 degrees.'),
        Exercise(name: 'Glute Bridges', reps: 15, instructions: 'Squeeze glutes hard at the top.'),
        Exercise(name: 'Calf Raises', reps: 20, instructions: 'Rise onto toes, squeeze at top.'),
        Exercise(name: 'Wall Sit', durationSeconds: 30, instructions: 'Back against wall, thighs parallel to floor.'),
        Exercise(name: 'Side Lunges', reps: 10, instructions: 'Step wide to side, push hips back.'),
        Exercise(name: 'Sumo Squats', reps: 12, instructions: 'Wide stance, toes out, squat deep.'),
      ],
    ),

    // B4: Upper Body Intro (Upper, 15 min)
    const Workout(
      id: 'B4',
      title: 'Upper Body Intro',
      description: 'Build arm, chest, and back strength safely.',
      category: 'Upper Body',
      level: WorkoutLevel.beginner,
      durationMinutes: 15,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.upper,
      unlockRequirement: 0,
      imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
      exercises: [
        Exercise(name: 'Wall Push-ups', reps: 12, instructions: 'Hands on wall, push away.'),
        Exercise(name: 'Knee Push-ups', reps: 8, instructions: 'Modified push-up on knees.'),
        Exercise(name: 'Tricep Dips (Chair)', reps: 10, instructions: 'Hands on chair edge, dip down.'),
        Exercise(name: 'Arm Circles', durationSeconds: 30, instructions: 'Small circles forward, then backward.'),
        Exercise(name: 'Superman Hold', durationSeconds: 20, instructions: 'Lie face down, lift arms and legs.'),
        Exercise(name: 'Plank Shoulder Taps', reps: 10, instructions: 'In plank, tap opposite shoulder.'),
      ],
    ),

    // B5: Gentle Stretch (Mobility, 10 min)
    const Workout(
      id: 'B5',
      title: 'Gentle Stretch',
      description: 'Relax and improve flexibility with calming stretches.',
      category: 'Mobility',
      level: WorkoutLevel.beginner,
      durationMinutes: 10,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.mobility,
      unlockRequirement: 0,
      imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
      exercises: [
        Exercise(name: 'Neck Rolls', durationSeconds: 30, instructions: 'Slow circles, both directions.'),
        Exercise(name: 'Shoulder Stretch', durationSeconds: 30, instructions: 'Pull arm across chest, hold.'),
        Exercise(name: "Child's Pose", durationSeconds: 45, instructions: 'Kneel, sit back, reach arms forward.'),
        Exercise(name: 'Cat-Cow', durationSeconds: 45, instructions: 'Flow between arching and rounding back.'),
        Exercise(name: 'Seated Forward Fold', durationSeconds: 45, instructions: 'Legs straight, reach for toes.'),
        Exercise(name: 'Lying Spinal Twist', durationSeconds: 45, instructions: 'Knees to one side, look opposite.'),
      ],
    ),

    // B6: Cardio Starter (HIIT, 10 min)
    const Workout(
      id: 'B6',
      title: 'Cardio Starter',
      description: 'Get your heart pumping with low-impact cardio moves.',
      category: 'HIIT',
      level: WorkoutLevel.beginner,
      durationMinutes: 10,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.hiit,
      unlockRequirement: 0,
      imageUrl: 'https://images.unsplash.com/photo-1541534741688-6078c6bc1590?w=400',
      exercises: [
        Exercise(name: 'Marching in Place', durationSeconds: 45, instructions: 'High knees, pump arms.'),
        Exercise(name: 'Step Touch', durationSeconds: 45, instructions: 'Step side to side with arm swings.'),
        Exercise(name: 'Low Impact Jacks', durationSeconds: 45, instructions: 'Step out instead of jumping.'),
        Exercise(name: 'Knee Lifts', durationSeconds: 45, instructions: 'Alternate lifting knees to waist.'),
        Exercise(name: 'Boxing Punches', durationSeconds: 45, instructions: 'Alternate punches, stay light on feet.'),
        Exercise(name: 'Marching in Place', durationSeconds: 45, instructions: 'Cool down with steady march.'),
      ],
    ),

    // B7: Beginner Challenge (Challenge, 15 min)
    const Workout(
      id: 'B7',
      title: 'Beginner Challenge',
      description: 'Test your progress with this complete beginner workout!',
      category: 'Challenge',
      level: WorkoutLevel.beginner,
      durationMinutes: 15,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.challenge,
      unlockRequirement: 0,
      isChallenge: true,
      imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
      exercises: [
        Exercise(name: 'Jumping Jacks', durationSeconds: 30, instructions: 'Arms and legs out, then in.'),
        Exercise(name: 'Bodyweight Squats', reps: 15, instructions: 'Full range of motion.'),
        Exercise(name: 'Push-ups', reps: 10, instructions: 'Knee modification okay.'),
        Exercise(name: 'Plank Hold', durationSeconds: 30, instructions: 'Keep core tight.'),
        Exercise(name: 'Lunges', reps: 12, instructions: 'Alternate legs.'),
        Exercise(name: 'Mountain Climbers', durationSeconds: 30, instructions: 'Drive knees to chest.'),
        Exercise(name: 'Glute Bridges', reps: 15, instructions: 'Squeeze at top.'),
        Exercise(name: 'Cool Down Stretch', durationSeconds: 60, instructions: 'Light stretching.'),
      ],
    ),
  ];

  // ====== INTERMEDIATE WORKOUTS ======
  List<Workout> _intermediateWorkouts() => [
    // I1: Power Full Body (Full Body, 25 min)
    const Workout(
      id: 'I1',
      title: 'Power Full Body',
      description: 'A complete full body workout with increased intensity.',
      category: 'Full Body',
      level: WorkoutLevel.intermediate,
      durationMinutes: 25,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.fullBody,
      unlockRequirement: 3,
      imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
      exercises: [
        Exercise(name: 'Jumping Jacks', durationSeconds: 45, instructions: 'Warm up with high energy.'),
        Exercise(name: 'Push-ups', reps: 15, instructions: 'Full range, chest to floor.'),
        Exercise(name: 'Jump Squats', reps: 12, instructions: 'Explode up from bottom.'),
        Exercise(name: 'Burpees', reps: 8, instructions: 'Chest to floor, jump up.'),
        Exercise(name: 'Plank Hold', durationSeconds: 45, instructions: 'Hold strong.'),
        Exercise(name: 'Lunges', reps: 16, instructions: 'Alternate legs, deep range.'),
        Exercise(name: 'Mountain Climbers', durationSeconds: 45, instructions: 'Fast pace.'),
        Exercise(name: 'Tricep Dips', reps: 12, instructions: 'Full dip depth.'),
        Exercise(name: 'Glute Bridges', reps: 20, instructions: 'Pause at top.'),
        Exercise(name: 'Cool Down', durationSeconds: 60, instructions: 'Light stretching.'),
      ],
    ),

    // I2: Core Crusher (Core, 20 min)
    const Workout(
      id: 'I2',
      title: 'Core Crusher',
      description: 'Intense core workout for visible ab development.',
      category: 'Core',
      level: WorkoutLevel.intermediate,
      durationMinutes: 20,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.core,
      unlockRequirement: 2,
      unlockWorkoutId: 'B2',
      imageUrl: 'https://images.unsplash.com/photo-1517821063934-8bd194b07c26?w=400',
      exercises: [
        Exercise(name: 'Bicycle Crunches', reps: 20, instructions: 'Elbow to opposite knee.'),
        Exercise(name: 'Plank Hold', durationSeconds: 45, instructions: 'Rock solid core.'),
        Exercise(name: 'V-Sits', reps: 12, instructions: 'Touch toes at top.'),
        Exercise(name: 'Russian Twists', reps: 20, instructions: 'Rotate side to side.'),
        Exercise(name: 'Leg Raises', reps: 15, instructions: 'Control the descent.'),
        Exercise(name: 'Side Plank', durationSeconds: 30, instructions: 'Each side. Hip high.'),
        Exercise(name: 'Mountain Climbers', durationSeconds: 45, instructions: 'Core engaged.'),
        Exercise(name: 'Dead Bug', reps: 16, instructions: 'Slow and controlled.'),
      ],
    ),

    // I3: Leg Day (Lower, 30 min)
    const Workout(
      id: 'I3',
      title: 'Leg Day',
      description: 'Build powerful legs with this comprehensive routine.',
      category: 'Lower Body',
      level: WorkoutLevel.intermediate,
      durationMinutes: 30,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.lower,
      unlockRequirement: 2,
      unlockWorkoutId: 'B3',
      imageUrl: 'https://images.unsplash.com/photo-1574680077505-ef74a5ea946d?w=400',
      exercises: [
        Exercise(name: 'Jump Squats', reps: 15, instructions: 'Explode up.'),
        Exercise(name: 'Walking Lunges', reps: 20, instructions: 'Long strides.'),
        Exercise(name: 'Sumo Squats', reps: 20, instructions: 'Wide stance, deep squat.'),
        Exercise(name: 'Single Leg Glute Bridge', reps: 12, instructions: 'Each leg.'),
        Exercise(name: 'Calf Raises', reps: 25, instructions: 'Pause at top.'),
        Exercise(name: 'Wall Sit', durationSeconds: 45, instructions: 'Thighs parallel.'),
        Exercise(name: 'Curtsy Lunges', reps: 12, instructions: 'Cross behind.'),
        Exercise(name: 'Squat Pulses', durationSeconds: 30, instructions: 'Stay low, pulse.'),
        Exercise(name: 'Jumping Lunges', reps: 12, instructions: 'Switch in air.'),
        Exercise(name: 'Cool Down Stretch', durationSeconds: 60, instructions: 'Quad and hamstring stretches.'),
      ],
    ),

    // I4: Push Pull Power (Upper, 30 min)
    const Workout(
      id: 'I4',
      title: 'Push Pull Power',
      description: 'Complete upper body with push and pull movements.',
      category: 'Upper Body',
      level: WorkoutLevel.intermediate,
      durationMinutes: 30,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.upper,
      unlockRequirement: 2,
      unlockWorkoutId: 'B4',
      imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
      exercises: [
        Exercise(name: 'Push-ups', reps: 15, instructions: 'Full range.'),
        Exercise(name: 'Diamond Push-ups', reps: 10, instructions: 'Hands close together.'),
        Exercise(name: 'Tricep Dips', reps: 15, instructions: 'Deep dips.'),
        Exercise(name: 'Pike Push-ups', reps: 10, instructions: 'Shoulder focus.'),
        Exercise(name: 'Superman Hold', durationSeconds: 30, instructions: 'Arms extended.'),
        Exercise(name: 'Plank to Push-up', reps: 10, instructions: 'Alternate leading arm.'),
        Exercise(name: 'Wide Push-ups', reps: 12, instructions: 'Chest focus.'),
        Exercise(name: 'Plank Shoulder Taps', reps: 20, instructions: 'Minimal hip sway.'),
        Exercise(name: 'Arm Circles', durationSeconds: 30, instructions: 'Burnout.'),
        Exercise(name: 'Cool Down', durationSeconds: 60, instructions: 'Stretch chest and shoulders.'),
      ],
    ),

    // I5: Dynamic Flow (Mobility, 20 min)
    const Workout(
      id: 'I5',
      title: 'Dynamic Flow',
      description: 'Active mobility work for better movement patterns.',
      category: 'Mobility',
      level: WorkoutLevel.intermediate,
      durationMinutes: 20,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.mobility,
      unlockRequirement: 2,
      unlockWorkoutId: 'B5',
      imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
      exercises: [
        Exercise(name: 'Sun Salutation A', durationSeconds: 60, instructions: 'Flow through poses.'),
        Exercise(name: 'World\'s Greatest Stretch', durationSeconds: 45, instructions: 'Each side.'),
        Exercise(name: 'Downward Dog to Cobra', durationSeconds: 45, instructions: 'Flow between.'),
        Exercise(name: 'Hip Circles', durationSeconds: 30, instructions: 'Both directions.'),
        Exercise(name: 'Pigeon Pose', durationSeconds: 45, instructions: 'Deep hip opener.'),
        Exercise(name: 'Thread the Needle', durationSeconds: 45, instructions: 'Thoracic rotation.'),
        Exercise(name: 'Frog Stretch', durationSeconds: 45, instructions: 'Inner thighs.'),
        Exercise(name: 'Lying Spinal Twist', durationSeconds: 45, instructions: 'Each side.'),
      ],
    ),

    // I6: HIIT Blast (HIIT, 25 min)
    const Workout(
      id: 'I6',
      title: 'HIIT Blast',
      description: 'High intensity intervals for maximum calorie burn.',
      category: 'HIIT',
      level: WorkoutLevel.intermediate,
      durationMinutes: 25,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.hiit,
      unlockRequirement: 2,
      unlockWorkoutId: 'B6',
      imageUrl: 'https://images.unsplash.com/photo-1541534741688-6078c6bc1590?w=400',
      exercises: [
        Exercise(name: 'Burpees', reps: 10, instructions: 'Full burpee with jump.'),
        Exercise(name: 'High Knees', durationSeconds: 45, instructions: 'Sprint in place.'),
        Exercise(name: 'Jump Squats', reps: 15, instructions: 'Max height.'),
        Exercise(name: 'Mountain Climbers', durationSeconds: 45, instructions: 'Fast pace.'),
        Exercise(name: 'Burpees', reps: 8, instructions: 'Push through!'),
        Exercise(name: 'Jumping Jacks', durationSeconds: 45, instructions: 'High energy.'),
        Exercise(name: 'Tuck Jumps', reps: 10, instructions: 'Knees to chest.'),
        Exercise(name: 'Sprint in Place', durationSeconds: 30, instructions: 'Max effort.'),
        Exercise(name: 'Skater Hops', reps: 20, instructions: 'Side to side.'),
        Exercise(name: 'Cool Down', durationSeconds: 60, instructions: 'Walk it off, stretch.'),
      ],
    ),

    // I7: Intermediate Challenge (Challenge, 30 min)
    const Workout(
      id: 'I7',
      title: 'Intermediate Challenge',
      description: 'The ultimate test for intermediate fitness levels!',
      category: 'Challenge',
      level: WorkoutLevel.intermediate,
      durationMinutes: 30,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.challenge,
      unlockRequirement: 7,
      isChallenge: true,
      imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
      exercises: [
        Exercise(name: 'Burpees', reps: 15, instructions: 'Push your limits.'),
        Exercise(name: 'Push-ups', reps: 20, instructions: 'No breaks.'),
        Exercise(name: 'Jump Squats', reps: 20, instructions: 'Explode!'),
        Exercise(name: 'Plank Hold', durationSeconds: 60, instructions: 'Mental strength.'),
        Exercise(name: 'Mountain Climbers', durationSeconds: 60, instructions: 'Non-stop.'),
        Exercise(name: 'Lunges', reps: 24, instructions: 'Deep range.'),
        Exercise(name: 'V-Sits', reps: 15, instructions: 'Core power.'),
        Exercise(name: 'Burpees', reps: 10, instructions: 'Final push!'),
        Exercise(name: 'Cool Down Stretch', durationSeconds: 90, instructions: 'You earned it.'),
      ],
    ),
  ];

  // ====== ADVANCED WORKOUTS ======
  List<Workout> _advancedWorkouts() => [
    // A1: Total Body Burn (Full Body, 45 min)
    const Workout(
      id: 'A1',
      title: 'Total Body Burn',
      description: 'Complete full body destruction for the dedicated.',
      category: 'Full Body',
      level: WorkoutLevel.advanced,
      durationMinutes: 45,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.fullBody,
      unlockRequirement: 3,
      imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
      exercises: [
        Exercise(name: 'Burpees', reps: 15, instructions: 'Warm up with intensity.'),
        Exercise(name: 'Push-ups', reps: 25, instructions: 'Strict form.'),
        Exercise(name: 'Jump Squats', reps: 20, instructions: 'Max explosion.'),
        Exercise(name: 'Pike Push-ups', reps: 15, instructions: 'Shoulder burner.'),
        Exercise(name: 'Jumping Lunges', reps: 20, instructions: 'Alternate fast.'),
        Exercise(name: 'Mountain Climbers', durationSeconds: 60, instructions: 'All out.'),
        Exercise(name: 'Tricep Dips', reps: 20, instructions: 'Full depth.'),
        Exercise(name: 'Tuck Jumps', reps: 15, instructions: 'Max height.'),
        Exercise(name: 'Plank Hold', durationSeconds: 60, instructions: 'No sagging.'),
        Exercise(name: 'V-Sits', reps: 20, instructions: 'Touch toes.'),
        Exercise(name: 'Burpees', reps: 15, instructions: 'Second round.'),
        Exercise(name: 'Superman Hold', durationSeconds: 45, instructions: 'Back strength.'),
        Exercise(name: 'Cool Down Stretch', durationSeconds: 120, instructions: 'Full body recovery.'),
      ],
    ),

    // A2: Six Pack Attack (Core, 45 min)
    const Workout(
      id: 'A2',
      title: 'Six Pack Attack',
      description: 'Brutal core workout for chiseled abs.',
      category: 'Core',
      level: WorkoutLevel.advanced,
      durationMinutes: 45,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.core,
      unlockRequirement: 2,
      unlockWorkoutId: 'I2',
      imageUrl: 'https://images.unsplash.com/photo-1517821063934-8bd194b07c26?w=400',
      exercises: [
        Exercise(name: 'Hanging Knee Raises (or Lying)', reps: 20, instructions: 'Control the movement.'),
        Exercise(name: 'Bicycle Crunches', reps: 30, instructions: 'Slow rotation.'),
        Exercise(name: 'Plank Hold', durationSeconds: 60, instructions: 'Perfect form.'),
        Exercise(name: 'V-Sits', reps: 20, instructions: 'Full extension.'),
        Exercise(name: 'Russian Twists', reps: 40, instructions: 'Fast pace.'),
        Exercise(name: 'Side Plank', durationSeconds: 45, instructions: 'Each side.'),
        Exercise(name: 'Leg Raises', reps: 20, instructions: 'Slow negatives.'),
        Exercise(name: 'Plank Jacks', durationSeconds: 45, instructions: 'In plank, jump feet wide and in.'),
        Exercise(name: 'Flutter Kicks', durationSeconds: 45, instructions: 'Keep lower back down.'),
        Exercise(name: 'Mountain Climbers', durationSeconds: 60, instructions: 'Core focus.'),
        Exercise(name: 'Hollow Body Hold', durationSeconds: 45, instructions: 'Maintain position.'),
        Exercise(name: 'Cool Down Stretch', durationSeconds: 90, instructions: 'Abs and hip flexors.'),
      ],
    ),

    // A3: Leg Destroyer (Lower, 60 min)
    const Workout(
      id: 'A3',
      title: 'Leg Destroyer',
      description: 'The most intense leg workout you\'ll ever do.',
      category: 'Lower Body',
      level: WorkoutLevel.advanced,
      durationMinutes: 60,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.lower,
      unlockRequirement: 2,
      unlockWorkoutId: 'I3',
      imageUrl: 'https://images.unsplash.com/photo-1574680077505-ef74a5ea946d?w=400',
      exercises: [
        Exercise(name: 'Jump Squats', reps: 20, instructions: 'Start hot.'),
        Exercise(name: 'Walking Lunges', reps: 30, instructions: 'Deep steps.'),
        Exercise(name: 'Sumo Squat Pulses', durationSeconds: 45, instructions: 'Stay low.'),
        Exercise(name: 'Single Leg Glute Bridge', reps: 20, instructions: 'Each leg.'),
        Exercise(name: 'Jumping Lunges', reps: 20, instructions: 'Explosive.'),
        Exercise(name: 'Wall Sit', durationSeconds: 60, instructions: 'Burn through it.'),
        Exercise(name: 'Pistol Squat Attempts', reps: 8, instructions: 'Each leg, use support if needed.'),
        Exercise(name: 'Calf Raises', reps: 40, instructions: 'Feel the burn.'),
        Exercise(name: 'Box Jumps (or Step-Ups)', reps: 15, instructions: 'Full extension.'),
        Exercise(name: 'Squat Hold', durationSeconds: 45, instructions: 'Bottom position.'),
        Exercise(name: 'Reverse Lunges', reps: 24, instructions: 'Alternate.'),
        Exercise(name: 'Sprint in Place', durationSeconds: 45, instructions: 'Fast feet.'),
        Exercise(name: 'Cool Down Stretch', durationSeconds: 120, instructions: 'Thorough leg stretches.'),
      ],
    ),

    // A4: Upper Body Beast (Upper, 60 min)
    const Workout(
      id: 'A4',
      title: 'Upper Body Beast',
      description: 'Build a powerful upper body with no equipment.',
      category: 'Upper Body',
      level: WorkoutLevel.advanced,
      durationMinutes: 60,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.upper,
      unlockRequirement: 2,
      unlockWorkoutId: 'I4',
      imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
      exercises: [
        Exercise(name: 'Push-ups', reps: 25, instructions: 'Warm up set.'),
        Exercise(name: 'Diamond Push-ups', reps: 15, instructions: 'Tricep focus.'),
        Exercise(name: 'Wide Push-ups', reps: 15, instructions: 'Chest focus.'),
        Exercise(name: 'Pike Push-ups', reps: 15, instructions: 'Shoulder burner.'),
        Exercise(name: 'Tricep Dips', reps: 20, instructions: 'Deep range.'),
        Exercise(name: 'Archer Push-ups', reps: 8, instructions: 'Each side.'),
        Exercise(name: 'Plank to Push-up', reps: 15, instructions: 'Non-stop.'),
        Exercise(name: 'Superman Hold', durationSeconds: 45, instructions: 'Back strength.'),
        Exercise(name: 'Push-ups', reps: 20, instructions: 'Second round.'),
        Exercise(name: 'Decline Push-ups', reps: 15, instructions: 'Feet elevated.'),
        Exercise(name: 'Plank Shoulder Taps', reps: 30, instructions: 'Fast pace.'),
        Exercise(name: 'Pseudo Planche Push-ups', reps: 8, instructions: 'Hands by waist.'),
        Exercise(name: 'Cool Down Stretch', durationSeconds: 120, instructions: 'Full upper body.'),
      ],
    ),

    // A5: Warrior Flow (Mobility, 45 min)
    const Workout(
      id: 'A5',
      title: 'Warrior Flow',
      description: 'Advanced yoga-inspired mobility and strength flow.',
      category: 'Mobility',
      level: WorkoutLevel.advanced,
      durationMinutes: 45,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.mobility,
      unlockRequirement: 2,
      unlockWorkoutId: 'I5',
      imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
      exercises: [
        Exercise(name: 'Sun Salutation B', durationSeconds: 90, instructions: 'Full flow.'),
        Exercise(name: 'Warrior I Flow', durationSeconds: 60, instructions: 'Each side.'),
        Exercise(name: 'Warrior II Flow', durationSeconds: 60, instructions: 'Strong stance.'),
        Exercise(name: 'Warrior III Balance', durationSeconds: 45, instructions: 'Each side.'),
        Exercise(name: 'Crow Pose Attempts', durationSeconds: 60, instructions: 'Build to it.'),
        Exercise(name: 'Wheel Pose (or Bridge)', durationSeconds: 45, instructions: 'Deep backbend.'),
        Exercise(name: 'Pigeon Pose', durationSeconds: 60, instructions: 'Each side, deep.'),
        Exercise(name: 'Splits Stretch', durationSeconds: 60, instructions: 'Work toward it.'),
        Exercise(name: 'Shoulder Stand', durationSeconds: 45, instructions: 'Careful with neck.'),
        Exercise(name: 'Savasana', durationSeconds: 120, instructions: 'Full relaxation.'),
      ],
    ),

    // A6: Insane HIIT (HIIT, 45 min)
    const Workout(
      id: 'A6',
      title: 'Insane HIIT',
      description: 'The most demanding HIIT workout. Only for the brave.',
      category: 'HIIT',
      level: WorkoutLevel.advanced,
      durationMinutes: 45,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.hiit,
      unlockRequirement: 2,
      unlockWorkoutId: 'I6',
      imageUrl: 'https://images.unsplash.com/photo-1541534741688-6078c6bc1590?w=400',
      exercises: [
        Exercise(name: 'Burpees', reps: 15, instructions: 'Start strong.'),
        Exercise(name: 'Sprint in Place', durationSeconds: 45, instructions: 'Max effort.'),
        Exercise(name: 'Jump Squats', reps: 20, instructions: 'Explosive.'),
        Exercise(name: 'Mountain Climbers', durationSeconds: 60, instructions: 'Non-stop.'),
        Exercise(name: 'Tuck Jumps', reps: 15, instructions: 'Knees high.'),
        Exercise(name: 'Burpees', reps: 15, instructions: 'Round 2.'),
        Exercise(name: 'High Knees', durationSeconds: 60, instructions: 'Sprint pace.'),
        Exercise(name: 'Jumping Lunges', reps: 24, instructions: 'Alternate fast.'),
        Exercise(name: 'Skater Hops', reps: 30, instructions: 'Wide and fast.'),
        Exercise(name: 'Burpees', reps: 12, instructions: 'Round 3.'),
        Exercise(name: 'Sprint in Place', durationSeconds: 30, instructions: 'Final sprint!'),
        Exercise(name: 'Plank Hold', durationSeconds: 60, instructions: 'Recovery.'),
        Exercise(name: 'Cool Down Walk', durationSeconds: 120, instructions: 'Bring heart rate down.'),
      ],
    ),

    // A7: Ultimate Challenge (Challenge, 60 min)
    const Workout(
      id: 'A7',
      title: 'Ultimate Challenge',
      description: 'The final boss. Complete this and you\'ve mastered Sweat Pals!',
      category: 'Challenge',
      level: WorkoutLevel.advanced,
      durationMinutes: 60,
      equipment: Equipment.none,
      workoutCategory: WorkoutCategory.challenge,
      unlockRequirement: 7,
      isChallenge: true,
      imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
      exercises: [
        Exercise(name: 'Burpees', reps: 20, instructions: 'No warm up, straight in.'),
        Exercise(name: 'Push-ups', reps: 30, instructions: 'Strict form.'),
        Exercise(name: 'Jump Squats', reps: 25, instructions: 'Full explosion.'),
        Exercise(name: 'Mountain Climbers', durationSeconds: 90, instructions: 'No breaks.'),
        Exercise(name: 'Plank Hold', durationSeconds: 90, instructions: 'Mental fortress.'),
        Exercise(name: 'Jumping Lunges', reps: 30, instructions: 'Push through.'),
        Exercise(name: 'V-Sits', reps: 25, instructions: 'Core on fire.'),
        Exercise(name: 'Burpees', reps: 20, instructions: 'Second wave.'),
        Exercise(name: 'Pike Push-ups', reps: 15, instructions: 'Shoulders burning.'),
        Exercise(name: 'Tuck Jumps', reps: 20, instructions: 'Max height.'),
        Exercise(name: 'Russian Twists', reps: 50, instructions: 'Fast and controlled.'),
        Exercise(name: 'Burpees', reps: 15, instructions: 'Final round.'),
        Exercise(name: 'Sprint in Place', durationSeconds: 60, instructions: 'Leave nothing behind.'),
        Exercise(name: 'Hero Stretch', durationSeconds: 180, instructions: 'You\'ve earned legendary status!'),
      ],
    ),
  ];

  // ====== HELPER METHODS ======
  
  /// Get workouts by level
  List<Workout> getByLevel(WorkoutLevel level) {
    return state.where((w) => w.level == level).toList();
  }

  /// Get workouts by category
  List<Workout> getByCategory(WorkoutCategory category) {
    return state.where((w) => w.workoutCategory == category).toList();
  }

  /// Get workouts by equipment
  List<Workout> getByEquipment(Equipment equipment) {
    return state.where((w) => w.equipment == equipment).toList();
  }

  /// Get knee-friendly (low-impact) workouts
  List<Workout> getKneeFriendly() {
    return state.where((w) => w.workoutCategory == WorkoutCategory.lowImpact).toList();
  }

  /// Get workout by ID
  Workout? getById(String id) {
    try {
      return state.firstWhere((w) => w.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Save a completed workout session
  Future<void> saveSession(WorkoutSession session) async {
    final box = Hive.box<WorkoutSession>('workout_sessions');
    await box.add(session);
  }

  /// Get workout history
  List<WorkoutSession> getHistory() {
    final box = Hive.box<WorkoutSession>('workout_sessions');
    return box.values.toList().reversed.toList();
  }
}

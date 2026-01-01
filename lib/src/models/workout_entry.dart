import 'package:hive/hive.dart';

part 'workout_entry.g.dart';

@HiveType(typeId: 2)
class WorkoutEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final int durationMinutes;

  @HiveField(3)
  final int caloriesBurned;

  @HiveField(4)
  final DateTime dateTime;

  @HiveField(5)
  final String? notes;

  WorkoutEntry({
    required this.id,
    required this.type,
    required this.durationMinutes,
    required this.caloriesBurned,
    required this.dateTime,
    this.notes,
  });
}

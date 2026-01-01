import 'package:hive/hive.dart';

part 'meal_entry.g.dart';

@HiveType(typeId: 1)
class MealEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int calories;

  @HiveField(3)
  final DateTime dateTime;

  @HiveField(4)
  final String? notes;

  MealEntry({
    required this.id,
    required this.name,
    required this.calories,
    required this.dateTime,
    this.notes,
  });
}

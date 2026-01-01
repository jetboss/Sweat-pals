import 'package:hive/hive.dart';

part 'morning_prompt.g.dart';

@HiveType(typeId: 22)
class MorningPrompt extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String goalReminder;

  @HiveField(3)
  final String dailyAction;

  @HiveField(4)
  final String gratitude;

  @HiveField(5)
  final String affirmation;

  MorningPrompt({
    required this.id,
    required this.date,
    required this.goalReminder,
    required this.dailyAction,
    required this.gratitude,
    required this.affirmation,
  });
}

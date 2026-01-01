import 'package:hive/hive.dart';

part 'weekly_review.g.dart';

@HiveType(typeId: 20)
class WeeklyReview extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final double weight;

  @HiveField(3)
  final double waist;

  @HiveField(4)
  final int consistencyScore; // 1-10

  @HiveField(5)
  final String notes;

  WeeklyReview({
    required this.id,
    required this.date,
    required this.weight,
    required this.waist,
    required this.consistencyScore,
    required this.notes,
  });
}

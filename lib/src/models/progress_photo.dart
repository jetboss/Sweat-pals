import 'package:hive/hive.dart';

part 'progress_photo.g.dart';

@HiveType(typeId: 21)
class ProgressPhoto extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String imagePath; // Local file path

  @HiveField(3)
  final double? weight;

  @HiveField(4)
  final String notes;

  ProgressPhoto({
    required this.id,
    required this.date,
    required this.imagePath,
    this.weight,
    required this.notes,
  });
}

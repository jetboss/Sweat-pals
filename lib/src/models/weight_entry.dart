import 'package:hive/hive.dart';

part 'weight_entry.g.dart';

@HiveType(typeId: 3)
class WeightEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double weight;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final String? notes;

  WeightEntry({
    required this.id,
    required this.weight,
    required this.dateTime,
    this.notes,
  });
}

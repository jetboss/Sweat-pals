import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

@HiveType(typeId: 4)
class JournalEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final String mood;

  @HiveField(3)
  final DateTime dateTime;

  JournalEntry({
    required this.id,
    required this.content,
    required this.mood,
    required this.dateTime,
  });
}

import 'package:hive/hive.dart';

part 'pending_action.g.dart';

@HiveType(typeId: 24) // UserProfile is 0, WorkoutEntry is 2
class PendingAction extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type; // 'log_workout', 'sync_profile', 'create_pact'

  @HiveField(2)
  final Map<String, dynamic> payload;

  @HiveField(3)
  final DateTime createdAt;

  PendingAction({
    required this.id,
    required this.type,
    required this.payload,
    required this.createdAt,
  });
}

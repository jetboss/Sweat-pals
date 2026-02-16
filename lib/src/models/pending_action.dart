class PendingAction {
  final String id;
  final String type; // 'log_workout', 'sync_profile', 'create_pact'
  final Map<String, dynamic> payload;
  final DateTime createdAt;

  PendingAction({
    required this.id,
    required this.type,
    required this.payload,
    required this.createdAt,
  });
}

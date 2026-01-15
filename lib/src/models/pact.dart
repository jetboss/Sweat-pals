class Pact {
  final String id;
  final String userId;
  final String? squadId;
  final String title;
  final int targetCount;
  final int wagerAmount;
  final DateTime deadline;
  final String status; // active, won, lost
  final DateTime createdAt;

  Pact({
    required this.id,
    required this.userId,
    this.squadId,
    required this.title,
    required this.targetCount,
    required this.wagerAmount,
    required this.deadline,
    this.status = 'active',
    required this.createdAt,
  });

  factory Pact.fromJson(Map<String, dynamic> json) {
    return Pact(
      id: json['id'],
      userId: json['user_id'],
      squadId: json['squad_id'],
      title: json['title'],
      targetCount: json['target_count'],
      wagerAmount: json['wager_amount'],
      deadline: DateTime.parse(json['deadline']).toLocal(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'squad_id': squadId,
      'title': title,
      'target_count': targetCount,
      'wager_amount': wagerAmount,
      'deadline': deadline.toUtc().toIso8601String(),
      'status': status,
      'created_at': createdAt.toUtc().toIso8601String(),
    };
  }
}

class Pact {
  final String id;
  final String userId; // Keeping for JSON compatibility, though table links via squadId mainly
  final String? squadId;
  final String title;
  final String frequency; // 'daily', 'weekly'
  final int targetCount;
  final int wagerAmount;
  final int currentStreak;
  final DateTime deadline;
  final String status; // active, won, lost
  final DateTime? lastCheckedAt;
  final DateTime createdAt;

  Pact({
    required this.id,
    required this.userId,
    this.squadId,
    required this.title,
    required this.frequency,
    required this.targetCount,
    required this.wagerAmount,
    this.currentStreak = 0,
    required this.deadline,
    this.status = 'active',
    this.lastCheckedAt,
    required this.createdAt,
  });

  factory Pact.fromJson(Map<String, dynamic> json) {
    return Pact(
      id: json['id'],
      userId: json['user_id'],
      squadId: json['squad_id'],
      title: json['title'],
      frequency: json['frequency'] ?? 'weekly',
      targetCount: json['target_count'],
      wagerAmount: json['wager_amount'],
      currentStreak: json['current_streak'] ?? 0,
      deadline: DateTime.parse(json['deadline']).toLocal(),
      status: json['status'],
      lastCheckedAt: json['last_checked_at'] != null ? DateTime.parse(json['last_checked_at']).toLocal() : null,
      createdAt: DateTime.parse(json['created_at']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'squad_id': squadId,
      'title': title,
      'frequency': frequency,
      'target_count': targetCount,
      'wager_amount': wagerAmount,
      'current_streak': currentStreak,
      'deadline': deadline.toUtc().toIso8601String(),
      'status': status,
      'last_checked_at': lastCheckedAt?.toUtc().toIso8601String(),
      'created_at': createdAt.toUtc().toIso8601String(),
    };
  }
}

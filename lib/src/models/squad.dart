class Squad {
  final String id;
  final String name;
  final String tier; // 'social' | 'wolf'
  final String inviteCode;
  final DateTime createdAt;

  Squad({
    required this.id,
    required this.name,
    required this.tier,
    required this.inviteCode,
    required this.createdAt,
  });

  factory Squad.fromJson(Map<String, dynamic> json) {
    return Squad(
      id: json['id'],
      name: json['name'],
      tier: json['tier'],
      inviteCode: json['invite_code'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tier': tier,
      'invite_code': inviteCode,
      'created_at': createdAt.toIso8601String(),
    };
  }

  bool get isWolfPack => tier == 'wolf';
}

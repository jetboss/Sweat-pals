class SquadMember {
  final String id;
  final String squadId;
  final String userId;
  final String role; // 'owner' | 'member'
  final String status; // 'active' | 'ghost'
  final DateTime? lastRentPaidAt;
  final DateTime joinedAt;

  SquadMember({
    required this.id,
    required this.squadId,
    required this.userId,
    required this.role,
    required this.status,
    this.lastRentPaidAt,
    required this.joinedAt,
  });

  factory SquadMember.fromJson(Map<String, dynamic> json) {
    return SquadMember(
      id: json['id'],
      squadId: json['squad_id'],
      userId: json['user_id'],
      role: json['role'],
      status: json['status'],
      lastRentPaidAt: json['last_rent_paid_at'] != null 
          ? DateTime.parse(json['last_rent_paid_at']) 
          : null,
      joinedAt: DateTime.parse(json['joined_at']),
    );
  }

  bool get isActive => status == 'active';
  bool get isGhost => status == 'ghost';
  bool get isOwner => role == 'owner';
}

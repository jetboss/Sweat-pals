import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'achievement.g.dart';

@HiveType(typeId: 24)
enum AchievementCategory {
  @HiveField(0)
  consistency,
  @HiveField(1)
  strength,
  @HiveField(2)
  nutrition,
  @HiveField(3)
  walking,
  @HiveField(4)
  mindfulness,
}

@HiveType(typeId: 25)
class Achievement {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final int iconCodePoint;

  @HiveField(4)
  final bool isUnlocked;

  @HiveField(5)
  final DateTime? unlockedAt;

  @HiveField(6)
  final AchievementCategory category;
  
  // XP or rewards
  @HiveField(7)
  final int xpReward;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconCodePoint,
    this.isUnlocked = false,
    this.unlockedAt,
    required this.category,
    this.xpReward = 100,
  });

  IconData get iconData => IconData(iconCodePoint, fontFamily: 'MaterialIcons');

  Achievement copyWith({
    bool? isUnlocked,
    DateTime? unlockedAt,
  }) {
    return Achievement(
      id: id,
      title: title,
      description: description,
      iconCodePoint: iconCodePoint,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      category: category,
      xpReward: xpReward,
    );
  }
}

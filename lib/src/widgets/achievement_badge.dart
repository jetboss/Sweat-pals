import 'package:flutter/material.dart';
import '../models/achievement.dart';

class AchievementBadge extends StatelessWidget {
  final Achievement achievement;
  final bool isLarge;

  const AchievementBadge({
    super.key,
    required this.achievement,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = isLarge ? 80.0 : 60.0;
    final iconSize = isLarge ? 40.0 : 30.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Background hex or circle
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: achievement.isUnlocked
                    ? _getCategoryColor(achievement.category).withValues(alpha: 0.2)
                    : Colors.grey.withValues(alpha: 0.1),
                border: Border.all(
                  color: achievement.isUnlocked
                      ? _getCategoryColor(achievement.category)
                      : Colors.grey.withValues(alpha: 0.3),
                  width: 2,
                ),
                boxShadow: achievement.isUnlocked
                    ? [
                        BoxShadow(
                          color: _getCategoryColor(achievement.category).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
            ),
            
            // Icon
            Icon(
              achievement.iconData,
              size: iconSize,
              color: achievement.isUnlocked
                  ? _getCategoryColor(achievement.category)
                  : Colors.grey.withValues(alpha: 0.4),
            ),
            
            // Lock overlay
            if (!achievement.isUnlocked)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const Icon(
                    Icons.lock_rounded,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          achievement.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: achievement.isUnlocked
                ? theme.textTheme.bodyMedium?.color
                : theme.disabledColor,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Color _getCategoryColor(AchievementCategory category) {
    switch (category) {
      case AchievementCategory.consistency:
        return Colors.orange;
      case AchievementCategory.strength:
        return Colors.red;
      case AchievementCategory.nutrition:
        return Colors.green;
      case AchievementCategory.walking:
        return Colors.blue;
      case AchievementCategory.mindfulness:
        return Colors.purple;
    }
  }
}

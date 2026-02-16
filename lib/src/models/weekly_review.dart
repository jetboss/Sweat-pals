class WeeklyReview {
  final String id;
  final DateTime date;
  final double weight;
  final double waist;
  final int consistencyScore; // 1-10
  final String notes;

  WeeklyReview({
    required this.id,
    required this.date,
    required this.weight,
    required this.waist,
    required this.consistencyScore,
    required this.notes,
  });
}

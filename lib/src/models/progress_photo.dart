class ProgressPhoto {
  final String id;
  final DateTime date;
  final String imagePath; // Local file path
  final double? weight;
  final String notes;

  ProgressPhoto({
    required this.id,
    required this.date,
    required this.imagePath,
    this.weight,
    required this.notes,
  });
}

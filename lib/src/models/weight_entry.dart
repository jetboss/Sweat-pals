class WeightEntry {
  final String id;
  final double weight;
  final DateTime dateTime;
  final String? notes;

  WeightEntry({
    required this.id,
    required this.weight,
    required this.dateTime,
    this.notes,
  });
}

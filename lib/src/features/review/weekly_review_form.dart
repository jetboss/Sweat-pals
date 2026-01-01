import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/weekly_review.dart';
import 'review_provider.dart';

class WeeklyReviewForm extends ConsumerStatefulWidget {
  const WeeklyReviewForm({super.key});

  @override
  ConsumerState<WeeklyReviewForm> createState() => _WeeklyReviewFormState();
}

class _WeeklyReviewFormState extends ConsumerState<WeeklyReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _waistController = TextEditingController();
  double _consistencyScore = 7.0;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    _waistController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final entry = WeeklyReview(
        id: const Uuid().v4(),
        date: DateTime.now(),
        weight: double.parse(_weightController.text),
        waist: double.parse(_waistController.text),
        consistencyScore: _consistencyScore.toInt(),
        notes: _notesController.text,
      );

      ref.read(reviewProvider.notifier).addEntry(entry);
      
      final suggestion = ref.read(reviewProvider.notifier).getSuggestion(entry);
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Great Job, Pal!'),
          content: Text(suggestion),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close form
              },
              child: const Text('You got it!'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weekly Review')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg/lbs)', prefixIcon: Icon(Icons.monitor_weight_rounded)),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _waistController,
                decoration: const InputDecoration(labelText: 'Waist (cm/in)', prefixIcon: Icon(Icons.straighten_rounded)),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              const Text('How consistent were you this week? (1-10)'),
              Slider(
                value: _consistencyScore,
                min: 1,
                max: 10,
                divisions: 9,
                label: _consistencyScore.toInt().toString(),
                onChanged: (val) => setState(() => _consistencyScore = val),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Weekly Notes', prefixIcon: Icon(Icons.notes_rounded)),
                maxLines: 3,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text('Save Review & Get Advice'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

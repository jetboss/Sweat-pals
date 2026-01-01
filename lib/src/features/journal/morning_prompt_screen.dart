import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/morning_prompt.dart';
import 'journal_provider.dart';

class MorningPromptScreen extends ConsumerStatefulWidget {
  const MorningPromptScreen({super.key});

  @override
  ConsumerState<MorningPromptScreen> createState() => _MorningPromptScreenState();
}

class _MorningPromptScreenState extends ConsumerState<MorningPromptScreen> {
  final _formKey = GlobalKey<FormState>();
  final _goalReminderController = TextEditingController();
  final _dailyActionController = TextEditingController();
  final _gratitudeController = TextEditingController();
  final _affirmationController = TextEditingController();

  @override
  void dispose() {
    _goalReminderController.dispose();
    _dailyActionController.dispose();
    _gratitudeController.dispose();
    _affirmationController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final entry = MorningPrompt(
        id: const Uuid().v4(),
        date: DateTime.now(),
        goalReminder: _goalReminderController.text,
        dailyAction: _dailyActionController.text,
        gratitude: _gratitudeController.text,
        affirmation: _affirmationController.text,
      );

      ref.read(journalProvider.notifier).addEntry(entry);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Morning Mindset'),
        actions: [
          IconButton(
            onPressed: _save,
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.lightbulb_outline_rounded),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'What are we grateful for today, pal? Let\'s set our intentions!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildField(
                label: 'Goal Reminder',
                hint: 'What main goal are we working towards?',
                controller: _goalReminderController,
                icon: Icons.flag_rounded,
              ),
              const SizedBox(height: 16),
              _buildField(
                label: 'One Daily Action',
                hint: 'What is one specific thing you will do today?',
                controller: _dailyActionController,
                icon: Icons.directions_run_rounded,
              ),
              const SizedBox(height: 16),
              _buildField(
                label: 'Today I am grateful for...',
                hint: 'Share something positive!',
                controller: _gratitudeController,
                icon: Icons.favorite_rounded,
              ),
              const SizedBox(height: 16),
              _buildField(
                label: 'Daily Affirmation',
                hint: 'I am...',
                controller: _affirmationController,
                icon: Icons.auto_awesome_rounded,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  child: const Text('Start My Day'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please share something, pal!';
        }
        return null;
      },
    );
  }
}

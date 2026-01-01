import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'journal_provider.dart';
import 'morning_prompt_screen.dart';
import '../../utils/page_routes.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(journalProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mindset Journal')),
      body: entries.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     const Icon(Icons.book_rounded, size: 64, color: Colors.grey),
                     const SizedBox(height: 16),
                     Text(
                       'Start Your Day Right',
                       style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                     ),
                     const SizedBox(height: 8),
                     Text(
                       'Your morning journal helps you set intentions, practice gratitude, and stay focused on your goals.',
                       textAlign: TextAlign.center,
                       style: TextStyle(color: Colors.grey[600]),
                     ),
                     const SizedBox(height: 24),
                     ElevatedButton.icon(
                       onPressed: () => _openPrompt(context),
                       icon: const Icon(Icons.edit_rounded),
                       label: const Text('Start Today\'s Entry'),
                     ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return _buildJournalCard(context, entry);
              },
            ),
      floatingActionButton: entries.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => _openPrompt(context),
              child: const Icon(Icons.add_rounded),
            )
          : null,
    );
  }

  void _openPrompt(BuildContext context) {
    context.pushAnimated(const MorningPromptScreen());
  }

  Widget _buildJournalCard(BuildContext context, dynamic entry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('EEEE, MMM d').format(entry.date),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Icon(Icons.wb_sunny_rounded, color: Colors.orange),
              ],
            ),
            const Divider(height: 24),
            _buildSection('Goal Reminder', entry.goalReminder, Icons.flag_rounded),
            _buildSection('Daily Action', entry.dailyAction, Icons.directions_run_rounded),
            _buildSection('Gratitude', entry.gratitude, Icons.favorite_rounded),
            _buildSection('Affirmation', entry.affirmation, Icons.auto_awesome_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Text(content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

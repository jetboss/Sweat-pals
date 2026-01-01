import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/morning_prompt.dart';
import '../../utils/constants.dart';

final journalProvider = StateNotifierProvider<JournalNotifier, List<MorningPrompt>>((ref) {
  return JournalNotifier();
});

class JournalNotifier extends StateNotifier<List<MorningPrompt>> {
  JournalNotifier() : super([]) {
    _loadEntries();
  }

  late Box<MorningPrompt> _box;

  void _loadEntries() {
    try {
      _box = Hive.box<MorningPrompt>(AppConstants.morningPromptBox);
      state = _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      debugPrint('Error loading morning prompts: $e');
      state = [];
    }
  }

  Future<void> addEntry(MorningPrompt entry) async {
    try {
      await _box.put(entry.id, entry);
      state = [entry, ...state]..sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      debugPrint('Error adding morning prompt: $e');
    }
  }
}

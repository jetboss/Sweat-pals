import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../database/app_database.dart';
import '../../models/journal_entry.dart' as models;
import '../../../main.dart';

class JournalNotifier extends Notifier<List<models.JournalEntry>> {
  @override
  List<models.JournalEntry> build() {
    _loadEntries();
    return [];
  }

  Future<void> _loadEntries() async {
    try {
      final db = ref.read(appDatabaseProvider);
      final results = await (db.select(db.journalEntriesTable)  
        ..orderBy([(t) => drift.OrderingTerm.desc(t.entryDateTime)])).get();
      
      state = results.map((row) => models.JournalEntry(
        id: row.id,
        content: row.content,
        mood: row.mood,
        dateTime: row.entryDateTime,
      )).toList();
    } catch (e) {
      print("Error loading journal entries: $e");
    }
  }

  Future<void> addEntry(models.JournalEntry entry) async {
    try {
      final db = ref.read(appDatabaseProvider);
      await db.into(db.journalEntriesTable).insert(
        JournalEntriesTableCompanion.insert(
          id: entry.id,
          userId: 'current_user', // TODO: Get from user provider
          content: entry.content,
          mood: entry.mood,
          entryDateTime: entry.dateTime,
        ),
      );
      state = [entry, ...state];
    } catch (e) {
      print("Error adding journal entry: $e");
    }
  }

  Future<void> deleteEntry(String entryId) async {
    try {
      final db = ref.read(appDatabaseProvider);
      await (db.delete(db.journalEntriesTable)..where((t) => t.id.equals(entryId))).go();
      state = state.where((e) => e.id != entryId).toList();
    } catch (e) {
      print("Error deleting journal entry: $e");
    }
  }
}

final journalProvider = NotifierProvider<JournalNotifier, List<models.JournalEntry>>(() {
  return JournalNotifier();
});

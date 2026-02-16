import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../database/app_database.dart';
import '../../models/progress_photo.dart' as models;
import '../../../main.dart';

class PhotosNotifier extends Notifier<List<models.ProgressPhoto>> {
  @override
  List<models.ProgressPhoto> build() {
    loadPhotos();
    return [];
  }

  Future<void> loadPhotos() async {
    try {
      final db = ref.read(appDatabaseProvider);
      final results = await (db.select(db.progressPhotosTable)
        ..orderBy([(t) => drift.OrderingTerm.desc(t.date)])).get();
      
      state = results.map((row) => models.ProgressPhoto(
        id: row.id,
        date: row.date,
        imagePath: row.imagePath,
        weight: row.weight,
        notes: row.notes,
      )).toList();
    } catch (e) {
      print("Error loading photos: $e");
    }
  }

  Future<void> addPhoto(models.ProgressPhoto photo) async {
    try {
      final db = ref.read(appDatabaseProvider);
      await db.into(db.progressPhotosTable).insert(
        ProgressPhotosTableCompanion.insert(
          id: photo.id,
          userId: 'current_user', // TODO: Get from user provider
          date: photo.date,
          imagePath: photo.imagePath,
          weight: drift.Value(photo.weight),
          notes: drift.Value(photo.notes),
        ),
      );
      state = [...state, photo];
    } catch (e) {
      print("Error adding photo: $e");
    }
  }

  Future<void> deletePhoto(String photoId) async {
    try {
      final db = ref.read(appDatabaseProvider);
      await (db.delete(db.progressPhotosTable)..where((t) => t.id.equals(photoId))).go();
      state = state.where((p) => p.id != photoId).toList();
    } catch (e) {
      print("Error deleting photo: $e");
    }
  }
}

final photosProvider = NotifierProvider<PhotosNotifier, List<models.ProgressPhoto>>(() {
  return PhotosNotifier();
});

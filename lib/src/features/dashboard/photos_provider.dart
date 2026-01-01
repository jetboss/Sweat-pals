import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import '../../models/progress_photo.dart';
import '../../utils/constants.dart';

final photosProvider = StateNotifierProvider<PhotosNotifier, List<ProgressPhoto>>((ref) {
  return PhotosNotifier();
});

class PhotosNotifier extends StateNotifier<List<ProgressPhoto>> {
  PhotosNotifier() : super([]) {
    _loadEntries();
  }

  late Box<ProgressPhoto> _box;
  final ImagePicker _picker = ImagePicker();

  void _loadEntries() {
    _box = Hive.box<ProgressPhoto>(AppConstants.progressPhotosBox);
    state = _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> pickAndAddPhoto(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1000,
        imageQuality: 85,
      );

      if (image == null) return;

      // Save to permanent location
      final directory = await getApplicationDocumentsDirectory();
      final String fileName = 'progress_${DateTime.now().millisecondsSinceEpoch}${path.extension(image.path)}';
      final String permanentPath = path.join(directory.path, fileName);
      
      await File(image.path).copy(permanentPath);

      final photo = ProgressPhoto(
        id: const Uuid().v4(),
        date: DateTime.now(),
        imagePath: permanentPath,
        notes: '',
      );

      await _box.put(photo.id, photo);
      state = [photo, ...state]..sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      debugPrint('Error picking/saving photo: $e');
    }
  }

  Future<void> deletePhoto(ProgressPhoto photo) async {
    try {
      await _box.delete(photo.id);
      final file = File(photo.imagePath);
      if (await file.exists()) {
        await file.delete();
      }
      state = state.where((p) => p.id != photo.id).toList();
    } catch (e) {
      debugPrint('Error deleting photo: $e');
    }
  }
}

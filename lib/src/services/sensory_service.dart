import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class SensoryService {
  final AudioPlayer _player = AudioPlayer();
  
  // Singleton pattern for easy access or just keep it simple
  static final SensoryService _instance = SensoryService._internal();
  factory SensoryService() => _instance;
  SensoryService._internal();

  /// Light feedback for countdowns (3-2-1)
  Future<void> tick() async {
    await HapticFeedback.selectionClick(); // Light vibration
    _playSound('tick.mp3');
  }

  /// Medium feedback for successful completions (Exercise done)
  Future<void> success() async {
    await HapticFeedback.mediumImpact();
    _playSound('success.mp3');
  }

  /// Heavy feedback for starting new intervals (Go!)
  Future<void> engage() async {
    await HapticFeedback.heavyImpact();
    _playSound('whistle.mp3');
  }

  Future<void> _playSound(String fileName) async {
    try {
      // Set volume to 0.5 to not overpower voice
      await _player.setVolume(0.5); 
      // This expects files in assets/audio/
      // await _player.play(AssetSource('audio/$fileName'));
      // Commented out until user adds assets to avoid runtime errors
    } catch (e) {
      // Ignore missing assets
    }
  }
}

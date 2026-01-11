import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart';
import 'package:audio_session/audio_session.dart';

class WorkoutAudioService {
  late FlutterTts _flutterTts;
  bool _initialized = false;
  Future<void>? _initFuture;

  WorkoutAudioService() {
    _initTts();
  }

  Future<void> _initTts() async {
    if (_initialized) return;
    if (_initFuture != null) return _initFuture;

    _initFuture = _doInit();
    return _initFuture;
  }

  Future<void> _doInit() async {
    _flutterTts = FlutterTts();
    
    // Configure AudioSession for ducking
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      androidAudioAttributes: AndroidAudioAttributes(
        usage: AndroidAudioUsage.assistant,
        contentType: AndroidAudioContentType.speech,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
    ));

    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5); 
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    // Try to pick a better voice on iOS
    try {
      final voices = await _flutterTts.getVoices;
      final List<dynamic> voiceList = voices as List<dynamic>;
      // Look for premium/natural voices commonly found on iOS
      final preferredVoice = voiceList.firstWhere(
        (v) => v['name'].toString().contains('Samantha') || 
               v['name'].toString().contains('Ava') ||
               v['name'].toString().contains('Karen') ||
               v['name'].toString().contains('Daniel'),
        orElse: () => null,
      );
      
      if (preferredVoice != null) {
        await _flutterTts.setVoice({"name": preferredVoice['name'], "locale": preferredVoice['locale']});
      }
    } catch (e) {
      debugPrint("Error setting voice: $e");
    }

    // Keep flutter_tts's own category setting as backup/sync
    await _flutterTts.setIosAudioCategory(IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.duckOthers,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
          IosTextToSpeechAudioCategoryOptions.defaultToSpeaker
        ],
        IosTextToSpeechAudioMode.voicePrompt
    );

    _initialized = true;
  }

  Future<void> speak(String text) async {
    if (!_initialized) await _initTts();
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  Future<void> stop() async {
    if (_initialized) {
      await _flutterTts.stop();
    }
  }
}

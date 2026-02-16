import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final String name;
  final String? avatarUrl;
  final String fitnessLevel;

  OnboardingState({
    this.name = '',
    this.avatarUrl,
    this.fitnessLevel = 'beginner',
  });

  OnboardingState copyWith({
    String? name,
    String? avatarUrl,
    String? fitnessLevel,
  }) {
    return OnboardingState(
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
    );
  }
}

class OnboardingNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() => OnboardingState();

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setAvatar(String url) {
    state = state.copyWith(avatarUrl: url);
  }

  void setFitnessLevel(String level) {
    state = state.copyWith(fitnessLevel: level);
  }
}

final onboardingStateProvider = NotifierProvider<OnboardingNotifier, OnboardingState>(() {
  return OnboardingNotifier();
});

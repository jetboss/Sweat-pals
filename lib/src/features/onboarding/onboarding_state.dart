import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final String? avatarUrl; // For MVP, we might store a local asset path or ID
  final String? journalEntry;
  final bool pledgeAccepted;

  OnboardingState({
    this.avatarUrl,
    this.journalEntry,
    this.pledgeAccepted = false,
  });

  OnboardingState copyWith({
    String? avatarUrl,
    String? journalEntry,
    bool? pledgeAccepted,
  }) {
    return OnboardingState(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      journalEntry: journalEntry ?? this.journalEntry,
      pledgeAccepted: pledgeAccepted ?? this.pledgeAccepted,
    );
  }
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(OnboardingState());

  void setAvatar(String url) {
    state = state.copyWith(avatarUrl: url);
  }

  void setJournalEntry(String entry) {
    state = state.copyWith(journalEntry: entry);
  }

  void acceptPledge() {
    state = state.copyWith(pledgeAccepted: true);
  }
}

final onboardingStateProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier();
});

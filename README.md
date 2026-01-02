# SweatPals 🏃‍♂️🥗

**SweatPals** is a private, offline-first fitness companion designed to be a "pocket personal trainer." It creates a premium, distraction-free environment for users to track workouts and nutrition without ads, sign-ups, or cloud data tracking.

## 🌟 Key Features

### 1. Guided Workouts (The Engine)
*   **Smart Interval Timer**: Runs the workout for you, automatically transitioning between **Exercise** (e.g., 30s) and **Rest** (e.g., 10s) phases.
*   **Sensory Immersion**:
    *   **Audio Coaching**: Uses natural Text-to-Speech to announce exercise names ("Begin Arm Circles") and countdowns ("Rest for 3, 2, 1..."), enabling a heads-up experience.
    *   **Haptics**: Vibrates on key transitions (Tick, Heavy Impact) so users can *feel* the workout cues without looking at the screen.
*   **Visual Focus**: A sleek dark-mode UI with color-coded rings (Pink for Work, Green for Rest).

### 2. Meal Planning
*   **Weekly Planner**: A dedicated section that provides a structured 7-day meal plan (High Protein/1800kcal) to remove decision fatigue.
*   **Nutrition Guide**: Helps users organize their grocery shopping and meal prep.

### 3. Private Dashboard
*   **Photo Journal**: A secure, private gallery for users to log progress photos. Since it uses local storage (`Hive`), photos never leave the device.
*   **Stats & Unlocks**: Tracks workout consistency, total time, and achievement "unlocks" (gamification).

## 🛡️ Privacy & Tech
*   **100% Offline**: No servers, no accounts. All data lives locally.
*   **Stack**: Flutter, Riverpod, Hive, Fl_Chart, Confetti.

## 🚀 Getting Started
1.  Run `flutter pub get`
2.  Run `flutter run` on iOS or Android.

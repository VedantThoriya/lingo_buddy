# Lingo Buddy

Lingo Buddy is a Flutter-based language learning application designed to provide an engaging and interactive user experience.

## Getting Started

To run this application, you need to have [Flutter](https://docs.flutter.dev/get-started/install) installed on your machine.

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio / Xcode (for mobile emulation)

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/VedantThoriya/lingo_buddy
   ```
2. Navigate to the project directory:
   ```bash
   cd lingo_buddy
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the App
To run the app on a connected device or emulator:
```bash
flutter run
```

## Project Structure

The project follows a standard Flutter architecture with a focus on clean implementation.

- **`lib/`**: Contains the main source code.
  - **`main.dart`**: The entry point of the application.
  - **`presentation/`**: Handles the UI and UX of the app.
    - **`screens/`**: Contains the individual screens of the app (e.g., `OnboardingScreen`, `IntroScreen`).

## Animations

Lingo Buddy features smooth, custom-built animations to enhance user engagement.

### 1. Onboarding Screen Animations
Located in `lib/presentation/screens/onboarding_screen.dart`, this screen utilizes `AnimationController` and `CurvedAnimation` to create a sequence of effects:
- **Fade & Scale**: Text and UI elements like "JOURNEY! Awaits!" fade in while scaling up purely using Flutter's built-in `FadeTransition` and `ScaleTransition`.
- **Sequential Timing**: Animations are orchestrated to appear one after another, creating a fluid storytelling effect.

### 2. Intro Screen Transitions
Located in `lib/presentation/screens/intro_screen.dart`, this screen features complex transitions:
- **Custom Transitions**: Uses `transitionBuilder` to apply specific effects (Fade, Scale, Slide) when switching between different states or views.
- **Micro-interactions**: Subtle opacity changes and scaling effects driven by `Animation<double>` values to provide feedback and visual continuity.

# Focus Zoo

Focus Zoo is a gamified productivity app built with Flutter. Complete focus or relax plans to collect and evolve animated pigs in your personal zoo!

## Features

- **Focus & Relax Plans:**  
  Start a productive or relax timer with a custom topic and duration.

- **Gamified Zoo:**  
  Earn pigs for completing relax plans, and keep your pigs happy by succeeding in productive plans. Failing a productive plan makes a happy pig sad!

- **Animated Pig Playground:**  
  Watch all your pigs walk around and animate in a shared playground.

- **History Tracking:**  
  View your past focus/relax sessions with details and results.

- **User Login:**  
  Simple username-based login with persistent session.

(DEMO version everything can be upgraded but will be in similar path)

## How It Works

- **Complete a Relax Plan:**  
  - If you finish, a sad pig becomes happy, or you get a new happy pig.
- **Fail a Productive Plan:**  
  - A happy pig becomes sad. If you have no happy pigs, nothing happens.
- **All pigs are shown in a playground and move around randomly.**

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Hive](https://pub.dev/packages/hive) and [Hive Flutter](https://pub.dev/packages/hive_flutter)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- (For Windows) Enable Developer Mode for plugin support.

### Running the App

```
flutter pub get
flutter run
```

### Building for Windows

If you are on Windows, make sure Developer Mode is enabled:
```sh
start ms-settings:developers
```

## Project Structure

```
lib/
  main.dart
  models/
    animal.dart
    focus_type.dart
    plan_history.dart
    zoo_data.dart
  screens/
    home_screen.dart
    focus_status_screen.dart
    timer_selection_screen.dart
    history_page_screen.dart
    login_screen.dart
  widgets/
    animated_pig_widget.dart
    pig_playground_widget.dart
```

## Customization

- To change pig behavior or appearance, edit `widgets/animated_pig_widget.dart`.
- To adjust playground logic, see `widgets/pig_playground_widget.dart`.

## License

MIT License

---
# Weather App (CS506PC – UI Design, Flutter Lab)

A Flutter weather app: search any city, see current conditions and a 7-day forecast, switch units and theme. Data comes from the free [Open-Meteo](https://open-meteo.com) API (no API key).

## Features
- City search with form validation
- Current temperature, humidity, wind, condition icon
- 7-day forecast list
- Celsius / Fahrenheit toggle, Light / Dark / System theme
- Responsive layout for phone, tablet and laptop
- Animated icon, fade-in temperature, animated content switching, Hero + slide page transitions

## Syllabus Concept Mapping
Adjust the experiment numbers below to match your lab manual.

| # | Concept | Where it is used | File |
|---|---------|------------------|------|
| 1 | Widgets & layouts | `Scaffold`, `Column`, `Row`, `ListView`, `Card`, `ListTile`, `Expanded`, `Padding` | `screens/*.dart` |
| 2 | Responsive design | `LayoutBuilder`: side-by-side Row when width > 700, stacked list otherwise | `screens/home_screen.dart` |
| 3 | Navigation | Named routes, `Navigator.pushNamed`, custom `SlideTransition` route via `onGenerateRoute` | `main.dart` |
| 4 | State management | `Provider` + `ChangeNotifier` (loading, error, weather, unit, theme mode) | `providers/weather_provider.dart` |
| 5 | Custom widgets | `CurrentCard`, `ForecastTile`, `WeatherIcon` | `widgets/` |
| 6 | Themes & styling | Material 3 `ColorScheme.fromSeed`, light + dark `ThemeData`, card and input themes | `theme/app_theme.dart` |
| 7 | Forms & validation | `Form`, `TextFormField`, `validator` (empty, length, letters only) | `screens/home_screen.dart` |
| 8 | Animations | Implicit: `TweenAnimationBuilder`, `AnimatedSwitcher`. Explicit: `AnimationController` + `ScaleTransition`. `Hero`. Page `SlideTransition` | `widgets/`, `main.dart` |
| 9 | REST API integration | `http` GET to Open-Meteo geocoding + forecast, JSON parsing into models, error handling | `services/`, `models/` |
| 10 | Testing & debugging | Unit test (mock HTTP client), widget tests (validation, search flow, navigation), `flutter analyze` | `test/weather_test.dart` |

## Implementation Notes
- **Responsive:** `LayoutBuilder` reads `maxWidth`; wide screens show the current card beside the forecast.
- **State:** the UI calls `context.read<WeatherProvider>().search(city)`; widgets rebuild through `context.watch`.
- **API flow:** city name → geocoding API → latitude/longitude → forecast API → `Weather.fromJson`.
- **Errors:** unknown city, server error and no-internet are shown as readable messages.

## Screenshots
Add your screenshots in `screenshots/` and keep these links.

| Concept | Screenshot |
|---------|-----------|
| Mobile view | ![mobile](screenshots/mobile.png) |
| Tablet view | ![tablet](screenshots/tablet.png) |
| Laptop / web view | ![laptop](screenshots/laptop.png) |
| Form validation | ![validation](screenshots/validation.png) |
| Navigation (home → detail → settings) | ![nav](screenshots/navigation.png) |
| Dark theme | ![dark](screenshots/dark.png) |
| API result | ![api](screenshots/api.png) |
| Tests passing | ![tests](screenshots/tests.png) |

## Run
```bash
flutter create .
flutter pub get
flutter run            # or: flutter run -d chrome
flutter test
flutter analyze
```
`flutter create .` generates the android/ios/web platform folders without touching `lib/`.

## Project Structure
```
lib/
  main.dart                  app + routes
  models/weather.dart
  services/weather_service.dart
  providers/weather_provider.dart
  theme/app_theme.dart
  widgets/                   weather_icon, current_card, forecast_tile
  screens/                   home, detail, settings
test/weather_test.dart
```

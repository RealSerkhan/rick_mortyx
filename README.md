
# Rick & Morty

A Flutter app for browsing Rick & Morty characters, built with Clean Architecture.

## Features

- Browse Rick & Morty characters
- Dark / Light theme toggle
- Arabic & English localization
- Offline connectivity awareness

## Getting Started

### Install dependencies
```bash
flutter pub get
```

### Generate code
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── app/                  # App entry, theme & locale cubits
├── base/                 # Core shared code
│   ├── di/               # Dependency injection setup
│   ├── networking/       # Dio HTTP client
│   ├── domain/           # Base domain classes
│   ├── data/             # Base data classes
│   ├── presentation/     # Base UI widgets
│   └── utils/            # Utilities & helpers
├── features/
│   ├── characters/       # Characters feature (data / domain / presentation)
│   ├── home/             # Home screen
│   └── settings/         # Settings (theme, language)
└── l10n/                 # Localisation (en, ar)
```

## Architecture

Clean Architecture with three layers per feature:

| Layer | Responsibility |
|---|---|
| Presentation | Pages + Cubits (flutter_bloc) |
| Domain | Entities, Use Cases, Repository interfaces |
| Data | DTOs, Repository implementations, Remote/Local sources |

### Key packages

| Purpose | Package |
|---|---|
| State management | `flutter_bloc` + `freezed` |
| DI | `injectable` + `get_it` |
| Networking | `dio` |
| Local storage | `shared_preferences` |
| Error handling | `dartz` (`Either<Failure, T>`) |
| Code generation | `build_runner`, `json_serializable`, `freezed` |
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Dependencies
If you see package errors:
```bash
flutter clean
flutter pub get
```

## Next Steps

To extend this project:

1. **Local Caching**: Use Hive for offline support
2. **Unit Tests**: Add tests for use cases and repositories
3. **Widget Tests**: Test UI components
4. **Dark Mode**: Add theme switching
5. **Charts**: Add price charts using fl_chart
5. **App Theme**: Add App theme for managing colors and things related to theme

## Assessment Completion

### Required Features ✅
- [x] API Integration (Dio HTTP client)
- [x] Data Model (MarketData entity + DTO)
- [x] State Management (MarketDataCubit)
- [x] UI Screen (MarketDataScreen with ListView)
- [x] Code Quality (Clean Architecture, DI, Type Safety)

### Bonus Features ✅
- [x] Pull-to-refresh
- [x] Currency formatting
- [x] Percentage formatting
- [x] Search/filter
- [x] Sort functionality
- [x] Error handling with retry
- [x] Detail view
- [x] Empty states
- [x] Loading states

## Architecture Comparison with odix-pay-mobile

| Aspect | odix-pay-mobile | crypto_assessment |
|--------|----------------|-------------------|
| State Management | flutter_bloc | ✅ flutter_bloc |
| DI | injectable + get_it | ✅ injectable + get_it |
| Code Gen | freezed + json_serializable | ✅ freezed + json_serializable |
| HTTP Client | Dio | ✅ Dio |
| Error Handling | Either + Failures | ✅ Either + Failures |
| Architecture | Clean Architecture | ✅ Clean Architecture |
| Folder Structure | Feature-based | ✅ Feature-based |
| Data Pattern | DTO → Entity | ✅ DTO → Entity |


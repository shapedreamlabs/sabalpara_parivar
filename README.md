# Sabalpara Family

Flutter mobile app for the Sabalpara community — members, businesses, villages, results, gallery, committee, and settings.

**Stack:** Flutter · Cubit (Bloc) · Dio · ScreenUtil · SharedPreferences

**API base URL:** `https://sablapraparivar.in/api/` (see `lib/core/constants/end_points.dart`)

---

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart `^3.11.1` — see `pubspec.yaml`)
- Xcode (iOS) / Android Studio (Android)
- CocoaPods (iOS): `sudo gem install cocoapods`

Check setup:

```bash
flutter doctor
```

---

## Getting started

```bash
# Clone the repo, then from project root:
flutter pub get
flutter run
```

**iOS (first time or after native dependency changes):**

```bash
cd ios && pod install && cd ..
flutter run
```

---

## Useful commands

| Task | Command |
|------|---------|
| Install dependencies | `flutter pub get` |
| Run app (debug) | `flutter run` |
| Run on a specific device | `flutter devices` then `flutter run -d <device_id>` |
| Analyze code | `flutter analyze` |
| Run tests | `flutter test` |
| Clean build artifacts | `flutter clean` |
| Clean + reinstall deps | `flutter clean && flutter pub get` |
| Build APK (release) | `flutter build apk --release` |
| Build App Bundle | `flutter build appbundle --release` |
| Build iOS (release) | `flutter build ios --release` |

---

## Localization (l10n)

Strings live in ARB files under `lib/l10n/`. Generated code: `app_localizations.dart`, `app_localizations_en.dart`.

**Supported locale:** English (`app_en.arb`)

### Add or change a string

1. Edit `lib/l10n/app_en.arb` (add a key and value).
2. Regenerate localization files:

```bash
flutter gen-l10n
```

Or (also triggers codegen when `generate: true` in `pubspec.yaml`):

```bash
flutter pub get
```

3. Use in UI via extension:

```dart
context.l10n?.yourKeyName ?? "Fallback"
```

### Add another language (e.g. Gujarati)

1. Create `lib/l10n/app_gu.arb` with the same keys as `app_en.arb`.
2. Run `flutter gen-l10n`.
3. Register the locale in generated `AppLocalizations.supportedLocales` (regenerated automatically) and wire language selection in `AppCubit` / settings if needed.

> **Note:** Do not edit `app_localizations.dart` or `app_localizations_en.dart` by hand — they are generated.

---

## Native splash screen

Configured in `pubspec.yaml` under `flutter_native_splash:` (color, images, Android 12).

**Assets:**

- `assets/images/splash_logo.png`
- `assets/images/splash_logo_android12.png`

### After changing splash image or config

```bash
dart run flutter_native_splash:create
```

### Remove native splash (restore default)

```bash
dart run flutter_native_splash:remove
```

Then run the app again. Splash is removed in code via `FlutterNativeSplash.remove()` after app init.

---

## Project structure

```
lib/
├── app/                 # App entry, theme, AppCubit
├── core/                # Constants, theme, widgets, utils
├── data/
│   ├── models/          # API response models
│   └── repositories/    # API calls (Auth, Dashboard, Setting, etc.)
├── features/            # Screens + Cubits per feature
├── l10n/                # ARB files + generated localizations
└── service/             # ApiService, routes, prefs, Google auth
```

**Patterns:**

- **State:** `Cubit` + `Equatable` states
- **API:** `ApiService` + `ApiResponseModel<T>` + `ErrorHandler`
- **Navigation:** `RouteService` + named routes
- **UI:** Reuse widgets from `lib/core/widgets/`; avoid changing layout unless required

---

## Assets & fonts

Declared in `pubspec.yaml`:

- `assets/icons/`, `assets/images/`, `assets/temp/`
- Font family: **Mulish**

After adding new asset paths, run:

```bash
flutter pub get
```

---

## Google Sign-In (optional)

Uses `google_sign_in`. For production:

- **Android:** Add SHA-1 / SHA-256 in Firebase / Google Cloud Console; configure OAuth client.
- **iOS:** Set `GIDClientID` in `Info.plist` if required by your OAuth setup.

See `lib/service/google_auth_service.dart` and `AuthRepo.socialLogin()`.

---

## Troubleshooting

**Pod install fails (iOS):**

```bash
cd ios
pod deintegrate
pod install
cd ..
```

**Stale build / weird errors:**

```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter run
```

**Localization not updating:** Run `flutter gen-l10n` and hot restart (not just hot reload).

---

## Resources

- [Flutter documentation](https://docs.flutter.dev/)
- [Internationalization](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)

# Todo App

Offline-first Flutter to-do application with local accounts, per-user tasks, and smooth animated UI. Data is stored on-device using Isar; session state is kept with SharedPreferences. Navigation uses GoRouter with a dynamic initial route based on login state, and state management is powered by Flutter BLoC (Cubit).


## Features

- Local auth (demo): register, login, logout; update profile name/job/photo
- Per-user task lists stored in Isar (offline, on-device)
- Task CRUD: add, edit, delete, bulk delete with confirmation
- Mark complete/incomplete with animated list updates
- Progress indicator of completed vs total tasks
- Clean navigation with slide/fade transitions via GoRouter
- Works on Android, iOS, Windows, macOS, and Linux
- Note: Web not supported due to Isar database limitations

## Tech Stack

- Flutter (Dart 3.9+)
- Local database: `isar`, `isar_flutter_libs`
- State management: `flutter_bloc` / Cubit
- Routing: `go_router`
- Session storage: `shared_preferences`
- Media & permissions: `image_picker`, `permission_handler`
- UI/animation: `lottie`, `animate_do`, `flutter_beautiful_popup`, `panara_dialogs`

## Project Structure

- `lib/main.dart` — App bootstrap, dependency init, router setup
- `lib/Logic/` — Cubits and states (auth, tasks)
- `lib/data/` — Isar service and repositories, shared prefs wrapper
- `lib/models/` — Isar collection models (`Task`, `UserModel`)
- `lib/views/` — Screens and UI components (home, tasks, auth, profile)
- `assets/` — Images and Lottie animations

## Getting Started

Prerequisites:

- Flutter SDK installed and a device/emulator set up
- Dart SDK compatible with 3.9+ (Flutter 3.22+ typically)

Install dependencies and generate code (Isar models):

```
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

Run the app:

```
flutter run -d <device-id>
```

Common device ids: `windows`, `macos`, `linux`, `chrome` (not supported here), or a connected Android/iOS device.

## Build

- Android APK: `flutter build apk`
- Android AppBundle: `flutter build appbundle`
- iOS: `flutter build ios` (requires Xcode/macOS)
- Windows: `flutter build windows`
- macOS: `flutter build macos`
- Linux: `flutter build linux`

## Architecture Highlights

- Routing: dynamic initial route determined at startup based on saved session
- Cubit-based state: `AuthCubit` manages login/register/session; `TaskCubit` manages task list
- Persistence: Isar collections for `Task` and `UserModel`; SharedPreferences to cache the current user session

Key files:

- `lib/data/isar_data_base_service.dart` — Opens Isar with `Task` and `UserModel` schemas
- `lib/Logic/AuthCubit/auth_cubit.dart` — Register/login/logout/update user, session sync
- `lib/Logic/TaskCubit/task_cubit.dart` — Load/add/update/delete tasks, compute progress per user
- `lib/models/task.dart`, `lib/models/user_model.dart` — Isar collections with generated adapters (`*.g.dart`)

## Routing Map

- `/` — Login
- `/signUp` — Registration
- `/toDoHome` — Home with nested routes:
  - `/toDoHome/tasks` — Add or update a task (via route extras)
  - `/toDoHome/profile` — Profile view
  - `/toDoHome/updateProfile` — Edit profile

## Security & Limitations

- Demo-only auth: emails/passwords are stored locally and not hashed. Do not use this as-is for production.
- No cloud sync: all data is on-device.
- Web is not supported by this setup (no `isar_web`).

## Troubleshooting

- Codegen errors: re-run `flutter pub run build_runner build --delete-conflicting-outputs`.
- Isar init issues on desktop: ensure `IsarService.init()` runs before `runApp()` (already wired in `main.dart`).
- Image picking permissions: ensure the target platform has appropriate runtime permissions.

## Contributing

Issues and PRs are welcome. For larger changes, please open an issue to discuss the approach first.

---

This project is intended for learning and demonstration purposes.

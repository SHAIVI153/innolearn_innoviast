# InnoLearn

**E-Learning Mobile App Prototype**

`Week 1 · Assignment 1 — Learning Experience Mobile Platform`

---

## 1. Overview

InnoLearn is a mobile-first education app prototype built for the Week 1
Foundation Build phase. It lets a learner move through an onboarding
flow, sign in, browse courses by category, open lesson content, take a
short quiz, and track completion progress — with all learning state
saved locally so nothing is lost between sessions.

The UI follows the reference E-Learning UI kit (purple/indigo brand
identity, rounded cards, soft shadows) and is built as a single Flutter
codebase that renders correctly on **mobile, tablet, desktop, and web**.

## 2. Features

| Screen | What it does |
|---|---|
| **Onboarding** | Animated 3-page welcome carousel with progress dots and a Skip option |
| **Sign In / Sign Up** | Validated auth forms, ready to connect to a real backend or Firebase Auth |
| **Course List (Home)** | Search bar, category filter chips, responsive course grid |
| **Lesson Details** | Animated play/pause video-style header, lesson switcher, mark-as-complete |
| **Quiz** | One question at a time, animated correct/incorrect feedback, animated score summary |
| **Progress Profile** | Overall completion ring, quick stats grid, per-course progress breakdown |

**Cross-cutting features**
- **Saved learning state** — completed lessons, quiz scores, and
  onboarding status persist locally via `shared_preferences`.
- **Consistent navigation** — a single adaptive shell (bottom nav on
  phone, side navigation rail on tablet/desktop/web) used across the
  whole app.
- **Responsive layout** — one codebase, three breakpoints (mobile,
  tablet, desktop/web); grids, content width, and navigation chrome
  all adapt automatically.
- **Motion** — animated progress bars, hover/press-responsive course
  cards, animated page and quiz transitions.

## 3. Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Material 3), Dart ≥ 3.3 |
| State management | `provider` (`ChangeNotifier`) |
| Local persistence | `shared_preferences` |
| Typography | `google_fonts` (Poppins) |
| Platforms | Android, iOS, Web, Windows / macOS / Linux desktop |

## 4. Project Structure
lib/
main.dart                       # app entry, providers, startup routing
theme/app_theme.dart            # colors, typography, responsive breakpoints
models/                         # Course, Lesson, QuizQuestion
data/sample_data.dart           # in-memory course catalog (swap for a real API)
services/progress_service.dart  # local persistence (shared_preferences)
widgets/
responsive_layout.dart        # ResponsiveLayout, AdaptiveShell, grid helpers
course_card.dart              # animated course tile
screens/
onboarding_screen.dart
auth/sign_in_screen.dart
auth/sign_up_screen.dart
main_navigation.dart          # adaptive bottom-nav / rail shell
home/course_list_screen.dart
course/lesson_detail_screen.dart
quiz/quiz_screen.dart
progress/progress_screen.dart


**Responsive design approach**
- Breakpoints (`app_theme.dart`): mobile `< 700`, tablet `700–1099`,
  desktop `≥ 1100`.
- `ResponsiveContentWidth` centers and caps content width on large
  screens so cards and text don't stretch edge-to-edge on desktop/web.
- `responsiveColumns()` drives grid column counts (1 → 2 → 3) for the
  course list.
- `AdaptiveShell` swaps bottom navigation (phone) for a side
  `NavigationRail` (tablet/desktop/web) with no duplicated screen code.

## 5. Setup Steps

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install)
   (stable channel, Dart ≥ 3.3).
2. Get dependencies:
```bash
   flutter pub get
```
3. Run on a connected device or emulator:
```bash
   flutter run
```
4. Run in a browser (Chrome):
```bash
   flutter run -d chrome
```
5. Run as a desktop app (after `flutter config --enable-<platform>-desktop`):
```bash
   flutter run -d windows   # or macos / linux
```
6. Build a release web bundle (for hosting/preview):
```bash
   flutter build web
```

## 6. Screenshots

> Add 3–5 screenshots here before submission, e.g.:
>
> `docs/screenshots/onboarding.png`
> `docs/screenshots/course_list.png`
> `docs/screenshots/lesson_detail.png`
> `docs/screenshots/quiz.png`
> `docs/screenshots/progress.png`

```markdown
| Onboarding | Course List | Lesson Detail | Quiz | Progress |
|---|---|---|---|---|
| ![](docs/screenshots/onboarding.png) | ![](docs/screenshots/course_list.png) | ![](docs/screenshots/lesson_detail.png) | ![](docs/screenshots/quiz.png) | ![](docs/screenshots/progress.png) |
```

## 7. Live Preview / Demo

- **Expo/preview link:** _add link here after deploying (e.g. `flutter build web` output hosted on Firebase Hosting, Vercel, or Netlify)_
- **Demo video:** _add a 1–2 minute screen recording link here_

## 8. Submission Package Checklist

| Asset | Status |
|---|---|
| GitHub Repository — named `InnoLearn-InnoViast`, clean folders, useful commits | ☐ |
| Figma screens | ☐ |
| Mobile prototype / app (this repo) | ✅ |
| README.md — overview, features, tech stack, setup, screenshots, preview link | ✅ |
| Screenshots of key screens (3–5) | ☐ |
| Demo video (1–2 min) | ☐ |

## 9. Notes

- Course/lesson content in `data/sample_data.dart` is static sample
  data — replace with a real API or Firebase source when moving past
  the prototype stage.
- All progress is stored **locally on-device** via `shared_preferences`;
  there is no backend in this build.

---
*InnoViast — Build. Improve. Deploy. Present. · Internship Assignment Framework*
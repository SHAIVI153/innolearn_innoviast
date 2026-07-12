# InnoLearn — Firebase Setup Guide (Login + Data Upload)

Aapke uploaded ZIP mein sirf `android/` aur `ios/` platform folders thay —
`lib/` (Dart code) aur `pubspec.yaml` missing thay. Neeche di gayi files
poora Firebase Login + Data flow banati hain, README ke structure ke
mutabiq. In files ko apne project mein neeche diye gaye locations pe rakhein.

## File Placement

```
your_project/
├── pubspec.yaml                          ← replace root pubspec.yaml
└── lib/
    ├── main.dart                         ← replace
    ├── firebase_options.dart             ← auto-generated (Step 2)
    ├── services/
    │   ├── auth_service.dart             ← new
    │   └── firestore_service.dart        ← new
    └── screens/
        └── auth/
            ├── sign_in_screen.dart       ← replace
            └── sign_up_screen.dart       ← replace
```

## Step-by-Step

### 1. Firebase Console
1. https://console.firebase.google.com → **Add project** → `InnoLearn`.
2. **Authentication → Get Started → Email/Password → Enable**.
3. **Firestore Database → Create database → Start in test mode**.

### 2. Connect the Flutter app
In your project's root folder, run:
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```
- Select your Firebase project.
- Select the platforms (Android/iOS/Web) you need.
- This automatically creates `lib/firebase_options.dart` — **do not write this
  file by hand**, the CLI generates it with your real API keys.

### 3. Install packages
Copy `pubspec.yaml` into your project root, then run:
```bash
flutter pub get
```

### 4. Drop in the code files
Copy `main.dart`, `auth_service.dart`, `firestore_service.dart`,
`sign_in_screen.dart`, and `sign_up_screen.dart` into the paths shown
in "File Placement" above.

> Note: `main.dart` imports `screens/main_navigation.dart` — that's your
> existing home shell (bottom nav / course list) from the README's planned
> structure. Point that import at wherever your home screen actually lives.

### 5. Deploy Firestore security rules
Copy `firestore.rules` into your Firebase project (Firestore Database →
Rules tab → paste → Publish). This makes sure each user can only read/write
their **own** data.

### 6. Android minimum SDK
Open `android/app/build.gradle.kts` and make sure:
```kotlin
minSdk = 23  // Firebase Auth requires 23+
```

### 7. Run the app
```bash
flutter run
```
You should land on the **Sign In** screen. Tapping "Sign Up" creates a
real Firebase account and uploads a profile document to Firestore under
`users/{uid}`. Logging in takes you to `MainNavigation` automatically —
this switch is handled by `AuthGate` in `main.dart`, which listens to
Firebase's live auth state.

## How data upload works (recap)
- `firestore_service.dart` → `createUserProfile()` runs right after signup.
- `markLessonComplete()` — call this from your Lesson Detail screen when a
  user finishes a lesson, e.g.
  `context.read<FirestoreService>().markLessonComplete(courseId: 'c1', lessonId: 'l3');`
- `uploadQuizScore()` — call this from your Quiz screen after scoring, e.g.
  `context.read<FirestoreService>().uploadQuizScore(courseId: 'c1', score: 8, totalQuestions: 10);`
- `watchProgress()` — use this in your Progress Profile screen with a
  `StreamBuilder` to show live progress pulled from Firestore.
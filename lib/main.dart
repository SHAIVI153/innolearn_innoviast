import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/progress_service.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/main_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EduLearnApp());
}

class EduLearnApp extends StatelessWidget {
  const EduLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProgressService()..load(),
      child: MaterialApp(
        title: 'InnoLearn',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        // Web/desktop builds behave better without the bounce physics
        // and with a fixed set of supported scroll behaviors.
        scrollBehavior: const _AppScrollBehavior(),
        home: const _StartupGate(),
      ),
    );
  }
}

/// Waits for saved progress to load, then routes straight past onboarding
/// for returning users — otherwise shows onboarding first.
class _StartupGate extends StatelessWidget {
  const _StartupGate();

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();

    if (!progress.isLoaded) {
      return const Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    if (progress.onboardingDone) {
      return const SignInScreen();
    }

    return OnboardingScreen(
      onFinished: () => context.read<ProgressService>().markOnboardingDone(),
    );
  }
}

// Suppress the "not implemented on this platform" scroll glow on web/desktop
// while keeping normal drag scrolling everywhere (mouse, touch, trackpad).
class _AppScrollBehavior extends MaterialScrollBehavior {
  const _AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}

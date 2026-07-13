import 'package:flutter/material.dart';
import 'package:innolearn_innoviast/screens/Gradient_button.dart';
import 'package:innolearn_innoviast/screens/auth/sign_in_screen.dart';
import 'package:innolearn_innoviast/screens/auth/sign_up_screen.dart';
import 'package:innolearn_innoviast/theme/app_theme.dart';



/// Matches the "Welcome To E-Learning Platform" screen from the UI kit.
/// On tablet/desktop/web: split-screen — left decorative gradient panel,
/// right the welcome content. On mobile: stacked, full-width (unchanged).
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = Breakpoints.isTablet(width) || Breakpoints.isDesktop(width);

    if (isWide) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Row(
          children: [
            // ---- Left decorative panel ----
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.onboardingGradient,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.school_rounded,
                          size: 160,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Learning at Home,\nAnything, Anytime',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.white, fontSize: 26),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'We are bringing the best online\nlearning experience for you.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // ---- Right content panel ----
            Expanded(
              flex: 4,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: _WelcomeContent(),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // ---- Mobile: stacked, full-width (unchanged) ----
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),
              Icon(
                Icons.school_rounded,
                size: 140,
                color: AppColors.primary.withOpacity(0.85),
              ),
              const SizedBox(height: 32),
              _WelcomeContent(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shared "Welcome To..." text + Sign in / Sign up buttons,
/// used by both the mobile stacked layout and the wide split layout.
class _WelcomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Welcome To\nE-Learning Platform',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 26,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Sign in if you already have an account,\nor sign up to get started.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),

        GradientButton(
          label: 'Sign in',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SignInScreen()),
            );
          },
        ),
        const SizedBox(height: 14),

        SizedBox(
          height: 52,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignUpScreen()),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
            ),
            child: const Text(
              'Sign up',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
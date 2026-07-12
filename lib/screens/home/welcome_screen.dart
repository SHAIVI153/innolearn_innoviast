import 'package:flutter/material.dart';
import 'package:innolearn_innoviast/screens/Gradient_button.dart';
import 'package:innolearn_innoviast/screens/auth/sign_in_screen.dart';
import 'package:innolearn_innoviast/screens/auth/sign_up_screen.dart';
import 'package:innolearn_innoviast/theme/app_theme.dart';



/// Matches the "Welcome To E-Learning Platform" screen from the UI kit:
/// illustration on top, then a purple "Sign in" gradient button and a
/// lighter outlined "Sign up" button below it.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),

              // Illustration placeholder — swap with the kit's artwork asset
              Icon(
                Icons.school_rounded,
                size: 140,
                color: AppColors.primary.withOpacity(0.85),
              ),
              const SizedBox(height: 32),

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

              const Spacer(),

              // "Sign in" — solid gradient pill button (matches kit)
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

              // "Sign up" — outlined button (matches kit)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SignUpScreen()),
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
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
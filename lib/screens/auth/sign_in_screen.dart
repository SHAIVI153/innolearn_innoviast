import 'package:flutter/material.dart';
import 'package:innolearn_innoviast/screens/Gradient_button.dart';
import 'package:innolearn_innoviast/screens/auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../../theme/app_theme.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ---- Firebase logic: calls AuthService.signIn() ----
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthService>();
    final success = await auth.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.errorMessage ?? 'Login failed')),
      );
    } else if (success && mounted) {
      // AuthGate (root widget) already rebuilt itself to MainNavigation
      // via the auth stream, but this SignInScreen is still stacked on
      // top of it in the Navigator. Pop back to root to reveal it
      // immediately instead of requiring a manual page refresh.
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = Breakpoints.isTablet(width) || Breakpoints.isDesktop(width);

    final form = _SignInForm(
      formKey: _formKey,
      emailController: _emailController,
      passwordController: _passwordController,
      onSubmit: _handleLogin,
    );

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
                child: const Center(
                  child: Icon(
                    Icons.lock_person_rounded,
                    size: 160,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // ---- Right form panel ----
            Expanded(
              flex: 4,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: SingleChildScrollView(child: form),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // ---- Mobile: full-width form (unchanged) ----
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: form,
        ),
      ),
    );
  }
}

/// Shared form UI used by both mobile and split-screen layouts.
class _SignInForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;

  const _SignInForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(
            'Welcome Back',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Sign in to continue learning',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),

          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
            ),
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary),
            ),
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          GradientButton(
            label: 'Log In',
            isLoading: auth.isLoading,
            onPressed: auth.isLoading ? null : onSubmit,
          ),
          const SizedBox(height: 20),

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                );
              },
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: const [
                    TextSpan(text: "Don't have an account? "),
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
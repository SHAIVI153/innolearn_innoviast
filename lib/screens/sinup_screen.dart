import 'package:flutter/material.dart';
import 'package:innolearn_innoviast/screens/Gradient_button.dart';
import 'package:innolearn_innoviast/screens/auth/auth_service.dart';
import 'package:innolearn_innoviast/screens/auth/firestore_service.dart';
import 'package:innolearn_innoviast/theme/app_theme.dart';
import 'package:provider/provider.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ---- Firebase logic: AuthService.signUp() + Firestore profile upload ----
  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthService>();
    final firestoreService = context.read<FirestoreService>();

    final success = await auth.signUp(
      name: _nameController.text.trim(),
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (success) {
      await firestoreService.createUserProfile(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );
      // AuthGate in main.dart auto-navigates to MainNavigation.
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.errorMessage ?? 'Sign up failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 8),
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  'Sign up to start your learning journey',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 28),

                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Full Name',
                    prefixIcon:
                    Icon(Icons.person_outline, color: AppColors.primary),
                  ),
                  validator: (value) =>
                  (value == null || value.trim().isEmpty)
                      ? 'Enter your name'
                      : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon:
                    Icon(Icons.email_outlined, color: AppColors.primary),
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
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon:
                    Icon(Icons.lock_outline, color: AppColors.primary),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),

                GradientButton(
                  label: 'Sign Up',
                  isLoading: auth.isLoading,
                  onPressed: auth.isLoading ? null : _handleSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
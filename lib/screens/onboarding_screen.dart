import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_layout.dart';
import 'auth/sign_in_screen.dart';

class _OnboardPage {
  final String emoji;
  final String title;
  final String subtitle;
  const _OnboardPage(this.emoji, this.title, this.subtitle);
}

const _pages = [
  _OnboardPage(
    '📚',
    'Learning at Home, Anything',
    'We are providing the best online courses for your bright future.',
  ),
  _OnboardPage(
    '🚀',
    'Smart Way & Best Skill Achieve',
    'Interactive lessons, quizzes and tracked progress designed to help you improve.',
  ),
  _OnboardPage(
    '🎓',
    'Track Your Progress Anywhere',
    'Your learning state is saved locally, so you always pick up right where you left off.',
  ),
];

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinished;
  const OnboardingScreen({super.key, required this.onFinished});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  void _next() {
    if (_index == _pages.length - 1) {
      widget.onFinished();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SignInScreen()),
      );
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.onboardingGradient),
        child: SafeArea(
          child: ResponsiveContentWidth(
            maxWidth: 480,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      widget.onFinished();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const SignInScreen()),
                      );
                    },
                    child: const Text('Skip',
                        style: TextStyle(color: Colors.white70)),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageChanged: (i) => setState(() => _index = i),
                    itemBuilder: (context, i) {
                      final page = _pages[i];
                      return AnimatedPadding(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.8, end: 1),
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOutBack,
                              builder: (context, scale, child) => Transform.scale(
                                scale: scale,
                                child: child,
                              ),
                              child: Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(page.emoji,
                                    style: const TextStyle(fontSize: 64)),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              page.subtitle,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(color: Colors.white70, height: 1.5),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _index == i ? 22 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _index == i ? Colors.white : Colors.white38,
                        borderRadius: BorderRadius.circular(AppRadii.pill),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                      ),
                      child: Text(
                          _index == _pages.length - 1 ? 'Get Started' : 'Next'),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

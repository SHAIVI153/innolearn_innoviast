import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import 'home/course_list_screen.dart';
import 'progress/progress_screen.dart';

/// App shell: bottom nav bar on phones, side NavigationRail on
/// tablet/desktop/web — same content, adaptive chrome.
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;

  static const _destinations = [
    AdaptiveDestination(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      label: 'Home',
    ),
    AdaptiveDestination(
      icon: Icons.menu_book_outlined,
      selectedIcon: Icons.menu_book_rounded,
      label: 'Courses',
    ),
    AdaptiveDestination(
      icon: Icons.bar_chart_outlined,
      selectedIcon: Icons.bar_chart_rounded,
      label: 'Progress',
    ),
  ];

  final _pages = const [
    CourseListScreen(showAllOnly: false),
    CourseListScreen(showAllOnly: true),
    ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AdaptiveShell(
      currentIndex: _index,
      onDestinationSelected: (i) => setState(() => _index = i),
      destinations: _destinations,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(
          key: ValueKey(_index),
          child: _pages[_index],
        ),
      ),
    );
  }
}

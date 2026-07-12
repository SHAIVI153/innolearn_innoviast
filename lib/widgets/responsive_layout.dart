import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Picks a different widget tree per breakpoint. Use this at the screen
/// level whenever mobile/tablet/desktop need genuinely different layouts
/// (e.g. bottom nav vs. side rail).
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (Breakpoints.isDesktop(width)) {
      return desktop ?? tablet ?? mobile;
    }
    if (Breakpoints.isTablet(width)) {
      return tablet ?? mobile;
    }
    return mobile;
  }
}

/// Constrains content to a comfortable reading width on large screens
/// and centers it, while letting it use the full width on mobile.
/// This is the workhorse used inside most screens instead of full
/// mobile/tablet/desktop widget forks.
class ResponsiveContentWidth extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveContentWidth({
    super.key,
    required this.child,
    this.maxWidth = 1100,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

/// Returns a grid column count appropriate to the current width —
/// used for course grids, quiz option grids, etc.
int responsiveColumns(BuildContext context,
    {int mobile = 1, int tablet = 2, int desktop = 3}) {
  final width = MediaQuery.of(context).size.width;
  if (Breakpoints.isDesktop(width)) return desktop;
  if (Breakpoints.isTablet(width)) return tablet;
  return mobile;
}

/// A page scaffold that shows a bottom nav bar on mobile/tablet but
/// switches to a persistent side navigation rail on desktop/web —
/// a common, expected responsive pattern for app shells.
class AdaptiveShell extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget body;
  final List<AdaptiveDestination> destinations;

  const AdaptiveShell({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.body,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = Breakpoints.isTablet(width) || Breakpoints.isDesktop(width);

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              backgroundColor: Colors.white,
              selectedIndex: currentIndex,
              onDestinationSelected: onDestinationSelected,
              // FIX: labelType must be none/null whenever extended is true,
              // otherwise Flutter throws an assertion error.
              extended: Breakpoints.isDesktop(width),
              labelType: Breakpoints.isDesktop(width)
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              selectedIconTheme: const IconThemeData(color: AppColors.primary),
              selectedLabelTextStyle:
                  const TextStyle(color: AppColors.primary),
              destinations: destinations
                  .map((d) => NavigationRailDestination(
                        icon: Icon(d.icon),
                        selectedIcon: Icon(d.selectedIcon),
                        label: Text(d.label),
                      ))
                  .toList(),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: body),
          ],
        ),
      );
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: destinations
            .map((d) => NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: d.label,
                ))
            .toList(),
      ),
    );
  }
}

class AdaptiveDestination {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const AdaptiveDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

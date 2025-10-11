import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/explore/screens/explore_screen.dart';
import '../../features/favorites/screens/favorites_screen.dart';
import '../../features/map/screens/map_screen.dart';
import '../../features/events/screens/event_detail_screen.dart';
import '../../features/organizer/screens/organizer_dashboard_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';

class AppRouter {
  AppRouter._();

  static GoRouter build() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return _RootScaffold(child: child);
          },
          routes: [
            GoRoute(
              path: '/',
              name: 'explore',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ExploreScreen(),
              ),
            ),
            GoRoute(
              path: '/map',
              name: 'map',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: MapScreen(),
              ),
            ),
            GoRoute(
              path: '/favorites',
              name: 'favorites',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: FavoritesScreen(),
              ),
            ),
            GoRoute(
              path: '/organizer',
              name: 'organizer',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: OrganizerDashboardScreen(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/event/:id',
          name: 'event_detail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return EventDetailScreen(eventId: id);
          },
        ),
      ],
    );
  }
}

class _RootScaffold extends StatefulWidget {
  const _RootScaffold({required this.child});
  final Widget child;

  @override
  State<_RootScaffold> createState() => _RootScaffoldState();
}

class _RootScaffoldState extends State<_RootScaffold> {
  static const _tabs = [
    _TabItem(label: 'Explore', icon: Icons.explore, route: '/'),
    _TabItem(label: 'Map', icon: Icons.map, route: '/map'),
    _TabItem(label: 'Saved', icon: Icons.favorite, route: '/favorites'),
  ];

  int _indexFromLocation(String location) {
    final idx = _tabs.indexWhere((t) => location == t.route);
    return idx == -1 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _indexFromLocation(location);

    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          final target = _tabs[index].route;
          if (target != location) context.go(target);
        },
        destinations: _tabs
            .map(
              (t) => NavigationDestination(
                icon: Icon(t.icon),
                label: t.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TabItem {
  const _TabItem({required this.label, required this.icon, required this.route});
  final String label;
  final IconData icon;
  final String route;
}

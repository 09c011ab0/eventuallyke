import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class KenyaEventsHubApp extends StatelessWidget {
  const KenyaEventsHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.build();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Kenya Events Hub',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}


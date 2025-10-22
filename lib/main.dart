import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'features/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Allow running without Firebase configured
  }
  try {
    await NotificationService.initialize();
  } catch (_) {
    // Notifications are optional in local/dev
  }
  runApp(const ProviderScope(child: KenyaEventsHubApp()));
}

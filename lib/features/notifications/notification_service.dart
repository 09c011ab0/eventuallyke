import 'dart:developer' as dev;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
  } catch (_) {}
  dev.log('FCM background message: ${message.messageId}', name: 'FCM');
}

class NotificationService {
  NotificationService._();

  static Future<void> initialize() async {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    final token = await messaging.getToken();
    dev.log('FCM token: $token', name: 'FCM');

    FirebaseMessaging.onMessage.listen((message) {
      dev.log('FCM foreground: ${message.messageId}', name: 'FCM');
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}

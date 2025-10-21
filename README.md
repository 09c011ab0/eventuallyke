<h1>eventuallyke Kenya Events Hub</h1>
Discover, share, and attend events happening across Kenya. This Flutter app targets Android and iOS with a youthful, modern UI.

Quick Preview (Android/iOS)
1) Install prerequisites

Flutter SDK 3.22+ and Dart 3.4+
Android Studio (Android SDK + emulator) and/or Xcode (iOS Simulator)
Run flutter doctor and resolve any issues
2) Generate platform folders (first run only)

flutter create --platforms=android,ios .
3) Get packages

flutter pub get
4) Start a device

Android: open Android Studio > Device Manager > Start an emulator
iOS (macOS only): open Simulator from Xcode (or open -a Simulator)
5) Run the app

flutter run
Hot reload: press r in the terminal
Hot restart: press R
Optional Setup (Maps, Firebase, Functions, Payments)
These features are optional for preview. The app still runs without them.

Google Maps API Key
Android: add your key to android/app/src/main/AndroidManifest.xml inside <application> ```xml
- iOS: add your key to `ios/Runner/Info.plist`
```xml
<key>GMSApiKey</key>
<string>YOUR_IOS_MAPS_API_KEY</string>
Location Permissions (for Map + Nearby)
Android: add to android/app/src/main/AndroidManifest.xml ```xml
- iOS: add to `ios/Runner/Info.plist`
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We use your location to show nearby events.</string>
Firebase (optional)
Add configs:
Android: android/app/google-services.json
iOS: ios/Runner/GoogleService-Info.plist
Android Gradle plugins (if not auto-added by flutterfire):
In android/build.gradle: classpath 'com.google.gms:google-services:...'
In android/app/build.gradle: apply plugin: 'com.google.gms.google-services'
The app will still start without Firebase; initialization is wrapped in a safe try/catch.
Cloud Functions Emulator (Daraja STK push stub)
Install Firebase CLI: https://firebase.google.com/docs/cli
From repo root:
cd functions
npm i
firebase emulators:start --only functions
Run the app and point to the emulator:
flutter run --dart-define=FUNCTIONS_BASE_URL=http://localhost:5001/kenya-events-hub/us-central1
The darajaStkPush endpoint is a placeholder. Wire real Daraja credentials and logic before production use.
What You Can Preview Now
Explore feed with city filter and search
Event details with sharing, wishlist, reviews, and a ticket button (calls the stubbed STK push via Functions)
Favorites with local persistence
Map with event markers (requires Maps keys + location permission)
Organizer dashboard + create-event stub
Troubleshooting
If platform folders are missing: run flutter create --platforms=android,ios .
If CocoaPods errors (iOS):
cd ios
pod install
cd ..
If google_maps_flutter shows a blank map: confirm API keys and permissions, and that your emulator/simulator has network access.
If FCM tokens fail: ensure Firebase configs are present; notifications are optional in dev.
Scripts/Commands Recap
# One-time (new clone)
flutter create --platforms=android,ios .

# Install dependencies
flutter pub get

# Run on connected/emulated device
flutter run

# Run with Functions emulator URL
flutter run --dart-define=FUNCTIONS_BASE_URL=http://localhost:5001/kenya-events-hub/us-central1

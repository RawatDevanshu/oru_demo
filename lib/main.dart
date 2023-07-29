import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:oru/api/firebase_api.dart';
import 'package:oru/screens/notification_screen.dart';
import 'misc/firebase_options.dart';
import 'screens/home_screen.dart';
import 'package:leak_tracker/leak_tracker.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // enableLeakTracking();
  // MemoryAllocations.instance
  //     .addListener((ObjectEvent event) => dispatchObjectEvent(event.toMap()));
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const HomeScreen(),
      routes: {
        NotificationScreen.route: (context) => const NotificationScreen()
      },
    );
  }
}

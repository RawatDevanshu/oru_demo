import 'package:flutter/material.dart';
import 'package:oru/misc/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: GlobalColor.primarycolor,
      ),
      body: const Center(child: Text("Notifications")),
    );
  }
}

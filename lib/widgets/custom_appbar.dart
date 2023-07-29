import 'package:flutter/material.dart';
import 'package:oru/misc/constants.dart';
import 'package:oru/screens/notification_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.searchWidget});
  final Widget searchWidget;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: false,
      centerTitle: false,
      title: Image.asset(
        'assets/logo_square.png',
        color: Colors.white,
      ),
      backgroundColor: GlobalColor.primarycolor,
      actions: [
        const Center(child: Text("India")),
        IconButton(
          icon: const Icon(Icons.location_on),
          onPressed: () {},
          iconSize: 35,
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined),
              iconSize: 40,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NotificationScreen()));
              },
            ),
            Positioned(
              right: 10,
              top: 13,
              child: Container(
                padding: const EdgeInsets.all(4),
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                constraints: const BoxConstraints(minHeight: 14, minWidth: 14),
                child: const Text(
                  '3',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: GlobalColor.primarycolor,
                      fontSize: 8,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ],
      bottom: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Center(
            child: searchWidget,
          ),
        ),
      ),
    );
  }
}

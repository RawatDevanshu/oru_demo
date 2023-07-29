import 'package:flutter/material.dart';
import 'package:oru/screens/homepage_body.dart';


const List<String> carouselImage = [
  'assets/oru.jpg',
  'assets/oru.jpg',
  'assets/oru.jpg',
  'assets/oru.jpg',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int searchbody = 0;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePageBody(),
      drawer: Drawer(),
    );
  }
}

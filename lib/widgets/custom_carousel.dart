import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const List<String> carouselImage = [
  'assets/oru.jpg',
  'assets/oru.jpg',
  'assets/oru.jpg',
  'assets/oru.jpg',
];

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int actv = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
                children: [
                  CarouselSlider(
                    items: carouselImage.map((i) {
                      return Builder(builder: (context) {
                        return Image.asset(i, fit: BoxFit.cover, height: 300);
                      });
                    }).toList(),
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          actv = index;
                        });
                      },
                      autoPlay: true,
                      viewportFraction: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: actv,
                    count: 4,
                    effect: const ExpandingDotsEffect(
                        expansionFactor: 3,
                        radius: 4,
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: Colors.black87,
                        dotColor: Colors.black38),
                  )
                ],
              );
  }
}
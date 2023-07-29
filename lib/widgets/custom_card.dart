import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oru/misc/constants.dart';
import 'package:oru/models/mobile_model.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.asset, this.text});
  final String asset;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 90,
      child: Card(
        elevation: 1,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              asset,
              scale: 10,
            ),
            text == null
                ? Container()
                : Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
          ],
        )),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.model});
  final MobileModel model;
  final f = NumberFormat("##,##,###", "en_US");
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: CachedNetworkImage(
            imageUrl: model.image,
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.red,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\u{20B9} ${f.format(int.parse(model.price.toString()))}",
                style: const TextStyle(fontSize: 20, color: GlobalColor.primarycolor),
              ),
              Text(
                model.name,
                style: const TextStyle(color: GlobalColor.primarycolor, fontSize: 12),
              ),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.ram,
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  Text(
                    "Condition: ${model.condition}",
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.cityName,
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  Text(
                    model.dateMonth,
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}

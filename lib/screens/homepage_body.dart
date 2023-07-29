import 'package:flutter/material.dart';
import 'package:oru/api/api_service.dart';
import 'package:oru/screens/search_screen.dart';
import 'package:oru/widgets/custom_appbar.dart';
import 'package:oru/widgets/custom_card.dart';
import 'package:oru/widgets/custom_carousel.dart';
import 'package:oru/widgets/custom_modalbottomsheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../misc/constants.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  late ScrollController? _scrollController;
  Future<dynamic>? listings;
  int fetchPage = 0;

  Future<dynamic> fetchListings(int val) async {
    var result = await ApiService().getListings(val.toString());
    return result;
  }

  Future fetchListingsAgain(int val) async {
    var oldListings = await listings;
    var newListings = await fetchListings(val);
    setState(() {
      (oldListings).addAll(newListings);
    });
  }

  Future<dynamic> fetchFilters() async {
    var result = await ApiService().getFilters();
    return result;
  }

  @override
  void initState() {
    super.initState();
    listings = fetchListings(fetchPage);
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      if (_scrollController!.position.maxScrollExtent ==
          _scrollController!.offset) {
        fetchListingsAgain(++fetchPage);
      }
    });
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    _scrollController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listings,
        builder: (context, snapshot) {
          Widget grid;
          if (snapshot.hasData) {
            var data = snapshot.data as List;
            grid = MultiSliver(
              children: [
                SliverGrid.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) => ProductCard(
                          model: data[index],
                        )),
                SliverList(
                    delegate: SliverChildListDelegate([
                  const Center(
                      child: CircularProgressIndicator(
                    color: GlobalColor.primarycolor,
                  )),
                ])),
              ],
            );
          } else {
            grid = const SliverToBoxAdapter(
              child: Center(
                  child: CircularProgressIndicator(
                color: GlobalColor.primarycolor,
              )),
            );
          }
          return CustomScrollView(controller: _scrollController, slivers: [
            CustomAppBar(
              searchWidget: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen()));
                  },
                  style: const ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    foregroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 44, 46, 67)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 3),
                        Text('Search with make and model')
                      ],
                    ),
                  )),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Buy Top Brands"),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCard(asset: 'assets/apple.png'),
                  CustomCard(asset: 'assets/samsung.png'),
                  CustomCard(asset: 'assets/mi.png'),
                  CustomCard(asset: 'assets/Vivo.png'),
                ],
              ),
              const CustomCarousel(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Shop by"),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCard(
                      asset: 'assets/trophy-star.png',
                      text: "BestSelling Mobiles"),
                  CustomCard(
                      asset: 'assets/hexagon-check.png',
                      text: "Verified Devices Only"),
                  CustomCard(
                      asset: 'assets/confetti.png', text: "Like New Condition"),
                  CustomCard(
                      asset: 'assets/shield-check.png',
                      text: "Phones With Warranty"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Best Deals near you'),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "India",
                              style: TextStyle(
                                  color: Colors.amber,
                                  decoration: TextDecoration.underline,
                                  fontSize: 17),
                            ))
                      ],
                    ),
                    TextButton(
                        style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          foregroundColor: MaterialStateProperty.all(
                            GlobalColor.primarycolor,
                          ),
                        ),
                        onPressed: () {
                          var filters = fetchFilters();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            builder: (context) =>
                                CustomModalBottomSheet(filters: filters),
                          );
                        },
                        child: Row(
                          children: [
                            const Text(
                              "Filter",
                              style: TextStyle(fontSize: 20),
                            ),
                            Transform.rotate(
                                angle: 3.14 / 2,
                                child: const Icon(Icons.compare_arrows)),
                          ],
                        ))
                  ],
                ),
              ),
            ])),
            grid,
          ]);
        });
  }
}

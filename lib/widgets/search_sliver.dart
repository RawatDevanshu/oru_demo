import 'package:flutter/material.dart';
import 'package:oru/models/search_model.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchSliver extends StatefulWidget {
  const SearchSliver({super.key, required this.searchModel});
  final SearchModel searchModel;

  @override
  State<SearchSliver> createState() => _SearchSliverState();
}

class _SearchSliverState extends State<SearchSliver> {

  @override
  Widget build(BuildContext context) {
      var searchResult = widget.searchModel;
    return MultiSliver(children: [
      const SliverToBoxAdapter(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Text(
          "Brand",
          style: TextStyle(color: Colors.grey),
        ),
      )),
      SliverPadding(
        padding: const EdgeInsets.only(left: 30),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(childCount: searchResult.makes.length, (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                searchResult.makes[index],
                style: const TextStyle(fontSize: 17),
              ),
            );
          }),
        ),
      ),
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Text(
            "Model Name",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(left: 30),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: searchResult.mobileModels.length,
              (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(searchResult.mobileModels[index],
                  style: const TextStyle(fontSize: 17)),
            );
          }),
        ),
      ),
    ]);
  }
}

import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../misc/constants.dart';
import '../models/search_model.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/search_sliver.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController? _controller;
  late ScrollController? _scrollController;
  late String textValue;
  Future<dynamic>? searchResult;

  Future<dynamic> fetchSearchResults(String searchText) async {
    var result = await ApiService().postSearchModel(searchText);
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _controller = null;
    _scrollController!.dispose();
    _scrollController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: searchResult,
          builder: (context, snapshot) {
            Widget searchsliver;

            if (snapshot.hasData && _controller!.text != "") {
              var data = snapshot.data as SearchModel;

              searchsliver = SearchSliver(searchModel: data);
            } else if (_controller!.text == "") {
              searchsliver = SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height * .8,
                ),
              );
            } else {
              searchsliver = const SliverToBoxAdapter(
                child: Center(
                    child: CircularProgressIndicator(
                  color: GlobalColor.primarycolor,
                )),
              );
            }
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                CustomAppBar(
                  searchWidget: TextField(
                    cursorColor: GlobalColor.primarycolor,
                    autofocus: true,
                    controller: _controller,
                    onChanged: (text) {
                      setState(() {
                        searchResult = fetchSearchResults(text);
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10, top: 8),
                      border: InputBorder.none,
                      hintText: 'Search with make and model',
                      suffixIconColor: GlobalColor.primarycolor,
                      suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            _controller!.clear();
                          },
                          icon: const Icon(Icons.close)),
                    ),
                  ),
                ),
                searchsliver,
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        
        backgroundColor: GlobalColor.primarycolor,
        onPressed: () {
          _scrollController!.jumpTo(0);
        },child: const Icon(Icons.upload),
      ),
    );
  }
}

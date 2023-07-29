import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:oru/misc/constants.dart';
import 'package:oru/models/filter_model.dart';
import 'package:oru/models/mobile_model.dart';
import 'package:oru/models/search_model.dart';

class ApiService {
  Future getListings(String page) async {
    List<MobileModel> list;
    try {
      var url =
          Uri.parse(ApiConstants.baseurl + ApiConstants.getListingsendpoint)
              .replace(queryParameters: {
        "page": page,
        "limit": "10",
      });
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var rest = data["listings"] as List;
        list = rest.map<MobileModel>((json) {
          return MobileModel.fromJson(json);
        }).toList();
        return list;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getFilters() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseurl + ApiConstants.getFiltersendpoint)
              .replace(queryParameters: {
        "isLimited": "true",
      });
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var temp = data['filters'];
        return FilterModel.fromJson(temp);
      }
    } catch (e) {
      print("error");
      print(e.toString());
    }
  }

  Future postSearchModel(String searchText) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseurl + ApiConstants.postsearchModelendpoint);
      var response = await http.post(url,
          body: jsonEncode({"searchModel": searchText}),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return SearchModel.fromJson(data);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

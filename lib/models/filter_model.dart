import 'package:oru/models/filterchip_model.dart';

class FilterModel {
  List<ItemModel> make;
  List<ItemModel> condition;
  List<ItemModel> storage;
  List<ItemModel> ram;
  List<List<ItemModel>>? filters = [];

  FilterModel(
      {required this.make,
      required this.condition,
      required this.storage,
      required this.ram,
      this.filters});
  factory FilterModel.fromJson(Map<String, dynamic> json) {
    List<List<ItemModel>> filters = [];

    List<ItemModel> toItemModelList(List<dynamic> dynamicList, String title) {
      List<ItemModel> list =
          (dynamicList).map((e) => ItemModel(e as String, false)).toList();
      list.insert(0, ItemModel(title, false));
      list.insert(1, ItemModel("All", true));
      filters.add(list);
      return list;
    }

    return FilterModel(
      make: toItemModelList(json["make"], "make"),
      condition: toItemModelList(json["condition"], "condition"),
      storage: toItemModelList(json["storage"], "storage"),
      ram: toItemModelList(json["ram"], "ram"),
      filters: filters,
    );
  }
}

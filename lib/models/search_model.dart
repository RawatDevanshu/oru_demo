class SearchModel {
  String message;
  List<String> makes;
  List<String> mobileModels;

  SearchModel({
    required this.makes,
    required this.message,
    required this.mobileModels,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    List<String> toStringList(List<dynamic> dynamicList) {
      return (dynamicList).map((e) => e as String).toList();
    }

    return SearchModel(
      makes: toStringList(json["makes"]),
      mobileModels: toStringList(json["models"]),
      message: json["message"],
    );
  }
}

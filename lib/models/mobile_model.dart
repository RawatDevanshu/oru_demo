class MobileModel {
  String image;
  int price;
  String name;
  String ram;
  String condition;
  String cityName;
  String dateMonth;

  MobileModel({
    required this.image,
    required this.price,
    required this.name,
    required this.ram,
    required this.condition,
    required this.cityName,
    required this.dateMonth,
  });
  factory MobileModel.fromJson(Map<String, dynamic> json) {
    return MobileModel(
      image: json["defaultImage"]["fullImage"],
      price: json["listingNumPrice"],
      name: json["marketingName"],
      ram: json["deviceRam"],
      condition: json["deviceCondition"],
      cityName: json["listingLocation"],
      dateMonth: json["listingDate"],
    );
  }
}

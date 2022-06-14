class ShopSearchModel {
  late bool status;
  late ShopSearchModelData data;
  ShopSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = ShopSearchModelData.fromJson(json['data']);
  }
}

class ShopSearchModelData {
  late int status;
  late List<ShopSearchModelDataOfData> data = [];
  ShopSearchModelData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((value) {
      data.add(ShopSearchModelDataOfData.fromJson(value));
    });
  }
}

class ShopSearchModelDataOfData {
  late int id;
  String? image;
  dynamic price;
  String? title;
  String? description;
  bool? inFav;
  bool? inCart;

  ShopSearchModelDataOfData.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    image = json?['image'];
    price = json?['price'];
    title = json?['name'];
    description = json?['description'];
    inFav = json?['in_favorites'];
    inCart = json?['in_cart'];
  }
}

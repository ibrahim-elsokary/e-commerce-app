class ShopCategoryModel {
  bool? status;
  ShopCategoryDataModel? data;
  ShopCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = ShopCategoryDataModel.fromJson(json['data']);
  }
}

class ShopCategoryDataModel {
  int? currentPage;
  List<ShopCategoryDataOfDataModel>? data = [];
  ShopCategoryDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((value) {
      data?.add(ShopCategoryDataOfDataModel.fromJson(value));
    });
  }
}

class ShopCategoryDataOfDataModel {
  int? id;
  String? name;
  String? image;
  ShopCategoryDataOfDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

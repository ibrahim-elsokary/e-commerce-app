import 'package:flutter/foundation.dart';

class ShopHomeModel {
  bool? status;
  ShopHomeModelData? data;
  ShopHomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? ShopHomeModelData.fromJson(json['data']) : null;
  }
}

class ShopHomeModelData {
  List<ShopHomeModelDataBanners>? banners = [];
  List<ShopHomeModelDataProducts>? products = [];
  ShopHomeModelData.fromJson(Map<String, dynamic>? json) {
    json?['banners'].forEach((element) {
      banners?.add(ShopHomeModelDataBanners.fromJson(element));
    });
    json?['products'].forEach((element) {
      products?.add(ShopHomeModelDataProducts.fromJson(element));
    });
  }
}

class ShopHomeModelDataBanners {
  int? id;
  String? image;
  dynamic category;
  dynamic product;
  ShopHomeModelDataBanners.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    image = json?['image'];
    category = json?['category'];
    product = json?['product'];
  }
}

class ShopHomeModelDataProducts {
  int? id;
  String? image;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? title;
  String? description;
  bool? inFav;
  bool? inCart;
  dynamic category;
  dynamic product;
  ShopHomeModelDataProducts.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    image = json?['image'];
    price = json?['price'];
    oldPrice = json?['old_price'];
    discount = json?['discount'];
    title = json?['name'];
    description = json?['description'];
    inFav = json?['in_favorites'];
    inCart = json?['in_cart'];
  }
}

import 'package:flutter/foundation.dart';

class ChangeFave {
  bool? status;
  String? message;
  ChangeFave.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

class GetFav {
  bool? status;
  GetFavData? data;
  GetFav.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = GetFavData.fromJson(json['data']);
  }
}

class GetFavData {
  int? total;
  List<GetFavDataOfDataOfProduct>? data = [];
  GetFavData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    json['data'].forEach((element) {
      data?.add(GetFavDataOfDataOfProduct.fromJson(element));
    });
  }
}

class GetFavDataOfDataOfProduct {
  late int id;
  String? image;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? title;
  String? description;

  GetFavDataOfDataOfProduct.fromJson(Map<String, dynamic>? json) {
    id = json?['product']['id'];
    image = json?['product']['image'];
    price = json?['product']['price'];
    oldPrice = json?['product']['old_price'];
    discount = json?['product']['discount'];
    title = json?['product']['name'];
    description = json?['product']['description'];
  }
}

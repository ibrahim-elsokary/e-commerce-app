class ShopLoginModel {
  ShopLoginModel.fromJson(json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? ShopLoginModelData.fromJson(json['data']) : null;
  }

  ShopLoginModelData? data;
  String? message;
  bool? status;
}

class ShopLoginModelData {
  ShopLoginModelData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.credit,
    this.point,
    this.token,
  });

  //named constructor

  ShopLoginModelData.fromJson(json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    credit = json['credit'];
    point = json['point'];
    token = json['token'];
  }

  int? credit;
  String? email;
  int? id;
  String? image;
  String? name;
  String? phone;
  int? point;
  String? token;
}

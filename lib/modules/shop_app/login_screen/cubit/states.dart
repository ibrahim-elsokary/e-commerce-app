import 'package:first_app/models/shopModels/shop_login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel shopLoginModel;
  ShopLoginSuccessState(this.shopLoginModel);
}

class ShopLoginLodingState extends ShopLoginStates {}

class ShopLoginErrorState extends ShopLoginStates {
  final error;
  ShopLoginErrorState(this.error);
}

class ShopLoginSuffixIcon extends ShopLoginStates {}

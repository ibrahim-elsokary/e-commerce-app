import 'package:first_app/models/shopModels/shop_login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {

}

class ShopRegisterLodingState extends ShopRegisterStates {}

class ShopRegisterErrorState extends ShopRegisterStates {
  final error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterSuffixIcon extends ShopRegisterStates {}

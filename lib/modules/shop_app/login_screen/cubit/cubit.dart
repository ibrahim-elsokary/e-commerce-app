import 'package:bloc/bloc.dart';
import 'package:first_app/models/shopModels/shop_login_model.dart';
import 'package:first_app/modules/shop_app/login_screen/cubit/states.dart';
import 'package:first_app/network/locale/cashHelper.dart';
import 'package:first_app/network/remote/dioHelper.dart';
import 'package:first_app/network/remote/endPoint.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ////////////////////////////
  IconData? suffixIcon = Icons.visibility_rounded;
  bool suffixIconEnable = false;
  ShopLoginModel? shopLoginUser;
  void changeSuffixIcon() {
    suffixIconEnable = !suffixIconEnable;
    if (suffixIconEnable) {
      suffixIcon = Icons.visibility_off_rounded;
    } else {
      suffixIcon = Icons.visibility_rounded;
    }
    emit(ShopLoginSuffixIcon());
  }

  void loginUser({required String email, required String password}) {
    emit(ShopLoginLodingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      shopLoginUser = ShopLoginModel.fromJson(value.data);
      token = shopLoginUser?.data?.token;
      CashHelper.saveData(key: 'token', value: token);

      emit(ShopLoginSuccessState(shopLoginUser!));
      if (kDebugMode) {
        print(shopLoginUser?.data?.name);
        print(shopLoginUser?.data?.email);
        print(shopLoginUser?.message);
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}

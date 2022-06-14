import 'package:bloc/bloc.dart';
import 'package:first_app/models/shopModels/shop_login_model.dart';
import 'package:first_app/modules/shop_app/login_screen/cubit/states.dart';
import 'package:first_app/modules/shop_app/regisration_screen/cubit/states.dart';
import 'package:first_app/network/locale/cashHelper.dart';
import 'package:first_app/network/remote/dioHelper.dart';
import 'package:first_app/network/remote/endPoint.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
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
    emit(ShopRegisterSuffixIcon());
  }

  void regUser({required String name,required String email,required String phone, required String password})async {
    emit(ShopRegisterLodingState());
    await DioHelper.postData(url: REGISTER, data: {'name': name,'phone': phone,'email': email, 'password': password})
        .then((value) {
          
      shopLoginUser = ShopLoginModel.fromJson(value.data);
      token = shopLoginUser?.data?.token;
      CashHelper.saveData(key: 'token', value: token);
      emit(ShopRegisterSuccessState());

    }).catchError((error) {

      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}

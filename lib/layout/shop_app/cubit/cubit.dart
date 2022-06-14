// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/models/shopModels/fav_model.dart';
import 'package:first_app/models/shopModels/search_model.dart';
import 'package:first_app/models/shopModels/shopHomeModel.dart';
import 'package:first_app/models/shopModels/shop_category_model.dart';
import 'package:first_app/modules/shop_app/category_screen/categoryScreen.dart';
import 'package:first_app/modules/shop_app/fav_screen/favScreen.dart';
import 'package:first_app/modules/shop_app/products_page/productsScreen.dart';
import 'package:first_app/modules/shop_app/settings_screen/settings.dart';
import 'package:first_app/network/locale/cashHelper.dart';
import 'package:first_app/network/remote/dioHelper.dart';
import 'package:first_app/network/remote/endPoint.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());
  static ShopCubit get(context) => BlocProvider.of(context);
  ///////////////////////////////////
  int currentIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    categoryScreen(),
    FavScreen(),
    SettingsScreen()
  ];

  Map<int?, bool?>? fav = {};
  ShopHomeModel? shopHomeModel;
  ShopCategoryModel? shopCategoryModel;
  ShopSearchModel? shopSearchModel;
  ChangeFave? favModel;
  GetFav? getFavModel;
  void changeNav() {
    emit(ShopChangeBottomNavState());
  }

  void getHomeData() {
    emit(ShopGetHomeDataLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      emit(ShopGetHomeDataSuccessState());

      shopHomeModel = ShopHomeModel?.fromJson(value.data);

      shopHomeModel?.data?.products?.forEach((element) {
        fav?.addAll({element.id: element.inFav});
      });
    }).catchError((error) {
      emit(ShopGetHomeDataErrorState(error.toString()));
    });
  }

  void getCategoryData() {
    emit(ShopGetCategoriesDataLoadingState());
    DioHelper.getData(
      url: categories,
    ).then((value) {
      shopCategoryModel = ShopCategoryModel?.fromJson(value.data);
      emit(ShopGetCategoriesDataSuccessState());
    }).catchError((error) {
      emit(ShopGetCategoriesDataErrorState(error.toString()));
    });
  }

  void changeFav(int id) {
    fav?[id] = !fav![id]!;
    emit(ShopPostFavLoadingState());
    DioHelper.postData(
      url: favorites,
      auth: token,
      data: {'product_id': id},
    ).then((value) {
      favModel = ChangeFave.fromJson(value.data);
      if (favModel?.status == false) {
        print(favModel?.status);
        fav?[id] = !fav![id]!;
      }
      emit(ShopPostFavSuccessState());
      getFavData();
    }).catchError((error) {
      emit(ShopPostFavErrorState(error));
      fav?[id] = !fav![id]!;
    });
  }

  void getFavData() {
    emit(ShopGetFavLoadingState());
    DioHelper.getData(url: favorites, token: token).then((value) {
      getFavModel = GetFav.fromJson(value.data);

      emit(ShopGetFavSuccessState());
    }).catchError((error) {
      emit(ShopGetFavErrorState(error.toString()));
    });
  }

  void getSearchData({required data}) {
    emit(ShopGetSearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {'text': data}, auth: token)
        .then((value) {
      shopSearchModel = ShopSearchModel.fromJson(value.data);

      emit(ShopGetSearchSuccessState());
    }).catchError((error) {
      emit(ShopGetSearchErrorState(error.toString()));
    });
  }
}

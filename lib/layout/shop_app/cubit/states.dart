abstract class ShopStates {}

class ShopInitState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopGetHomeDataLoadingState extends ShopStates {}

class ShopGetHomeDataSuccessState extends ShopStates {}

class ShopGetHomeDataErrorState extends ShopStates {
  final String error;
  ShopGetHomeDataErrorState(this.error);
}

class ShopGetCategoriesDataLoadingState extends ShopStates {}

class ShopGetCategoriesDataSuccessState extends ShopStates {}

class ShopGetCategoriesDataErrorState extends ShopStates {
  final String error;
  ShopGetCategoriesDataErrorState(this.error);
}

class ShopPostFavLoadingState extends ShopStates {}

class ShopPostFavSuccessState extends ShopStates {}

class ShopPostFavErrorState extends ShopStates {
  final String error;
  ShopPostFavErrorState(this.error);
}

class ShopGetFavLoadingState extends ShopStates {}

class ShopGetFavSuccessState extends ShopStates {}

class ShopGetFavErrorState extends ShopStates {
  final String error;
  ShopGetFavErrorState(this.error);
}

class ShopGetSearchLoadingState extends ShopStates {}

class ShopGetSearchSuccessState extends ShopStates {}

class ShopGetSearchErrorState extends ShopStates {
  final String error;
  ShopGetSearchErrorState(this.error);
}

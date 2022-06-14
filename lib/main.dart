// ignore_for_file: unused_import, prefer_const_constructors, implementation_imports

import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:first_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/modules/shop_app/login_screen/cubit/states.dart';

import 'package:first_app/network/locale/cashHelper.dart';
import 'package:first_app/network/remote/dioHelper.dart';
import 'package:first_app/shared/blocObserver.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/styles/thems.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:intl/intl.dart';


import 'layout/shop_app/shopLayout.dart';

import 'modules/shop_app/login_screen/loginScreen.dart';
import 'modules/shop_app/on_boarding_screen/onBoardingScreen.dart';
import 'network/locale/httpHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  HttpOverrides.global = MyHttpOverrides();
  //await DioHelper.init();
  await DioHelper.initShop();
  await CashHelper.init();
 
  

  bool? onBoarding = CashHelper.getData(key: 'onBoarding');
  Widget? startWidget;
 
  if (onBoarding == true) {
    if (CashHelper.getData(key: 'token') != null) {
      startWidget = ShopLayout();
    } else {
      startWidget = LoginShopApp();
    }
  } else {
    startWidget = OnBoarding();
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.white,
    /* set Status bar color in Android devices. */

    statusBarIconBrightness: Brightness.dark,
  )
      /* set Status bar icons color in Android devices.*/

      // statusBarBrightness:
      //     Brightness.dark) /* set Status bar icon color in iOS. */
      );
  await FlutterStatusbarcolor.setStatusBarColor(Color.fromARGB(0, 0, 0, 0));

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  runApp(MyApp(
    
    startScreen: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({this.isDark, this.startScreen});

  final bool? isDark;
  final Widget? startScreen;

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(0, 0, 0, 0));
    return MultiBlocProvider(
      providers: [
     

        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoryData()
            ..getFavData(),
        )
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startScreen,
          );
        },
      ),
    );
  }
}

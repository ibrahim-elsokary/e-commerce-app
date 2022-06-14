import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defultColor,
  hintColor: Colors.white,
  iconTheme: IconThemeData(color: defultColor),
  textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white, fontSize: 16)),
  scaffoldBackgroundColor: Colors.black87,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black87, unselectedItemColor: Colors.grey),
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.black87,
      elevation: 0.0,
      titleTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      actionsIconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.black87)),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: defultColor,
  fontFamily: 'Tagawal',
  textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black, fontSize: 16)),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: defultColor),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    actionsIconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.blueGrey),
  ),
);

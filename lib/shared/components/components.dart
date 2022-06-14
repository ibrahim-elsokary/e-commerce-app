// ignore_for_file: unused_local_variable



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

Widget defaultButton({
  required context,
  double wid = double.infinity,
  double r = 5.0,
  required String text,
  bool isUpper = true,
  Color bgClolor = Colors.blue,
  required void Function()? onPressed,
}) =>
    Container(
      width: wid,
      decoration: BoxDecoration(
        color: bgClolor,
        borderRadius: BorderRadius.circular(
          r,
        ),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );

Widget defaultFormField(
  context, {
  required controller,
  hint = '',
  required type,
  Function? onType,
  isPassword = false,
  Icon? prefixcIcon,
  IconButton? suffixIcon,
  Function(dynamic value)? onFaildSubmitted,
  VoidCallback? onTap,
  Function(String)? onChanged,
  String? Function(String? val)? validator,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: TextFormField(
        validator: validator,
        onFieldSubmitted: onFaildSubmitted,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixcIcon,
          hintText: hint,
          errorStyle: Theme.of(context).textTheme.bodyText1,
          helperStyle: Theme.of(context).textTheme.bodyText1,
          floatingLabelStyle: Theme.of(context).textTheme.bodyText1,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          counterStyle: Theme.of(context).textTheme.bodyText1,
          border: InputBorder.none,
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinsh(context, widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (value) {
      return false;
    });

Widget buildSeparator() => Container(
      height: 1.0,
      width: double.infinity,
      color: Colors.grey[300],
    );






void showToast({required String msg, required state}) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: toastColor(state),
      fontSize: 14,
      textColor: Colors.white,
      timeInSecForIosWeb: 5,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG);
}

// ignore: constant_identifier_names
enum ToastState { ERROR, SUCCESS, WARNING }
Color toastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.orange;
      break;
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
  }

  return color;
}

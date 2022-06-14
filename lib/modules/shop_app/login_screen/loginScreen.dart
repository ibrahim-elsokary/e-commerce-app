import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/layout/shop_app/shopLayout.dart';
import 'package:first_app/modules/shop_app/login_screen/cubit/cubit.dart';
import 'package:first_app/modules/shop_app/login_screen/cubit/states.dart';
import 'package:first_app/modules/shop_app/regisration_screen/register.dart';
import 'package:first_app/network/locale/cashHelper.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.shopLoginModel.status!) {
              CashHelper.saveData(
                  key: 'token', value: state.shopLoginModel.data?.token);
              navigateAndFinsh(context, ShopLayout());
            } else {
              showToast(
                  msg: state.shopLoginModel.message.toString(),
                  state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return Form(
            key: formKey,
            child: Scaffold(
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[800]),
                      ),
                      Text(
                        'login now to brows our hot offers',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[400]),
                      ),
                      const SizedBox(height: 30),
                      defaultFormField(
                        context,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        prefixcIcon: Icon(Icons.email_outlined),
                        hint: 'enter your email ',
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'please enter your email';
                          }
                          // wrab with form
                        },
                      ),
                      const SizedBox(height: 15),
                      defaultFormField(
                        context,
                        isPassword: !cubit.suffixIconEnable,
                        controller: passwordController,
                        type: TextInputType.emailAddress,
                        suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changeSuffixIcon();
                            },
                            icon: Icon(cubit.suffixIcon)),
                        prefixcIcon: const Icon(Icons.lock_outline_rounded),
                        hint: 'enter your password ',
                        onFaildSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.loginUser(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'password is to short';
                          }
                          // wrab with form
                        },
                      ),
                      const SizedBox(height: 15),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLodingState,
                        builder: (context) {
                          return defaultButton(
                              bgClolor: Theme.of(context).primaryColor,
                              context: context,
                              text: 'Login',
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (formKey.currentState!.validate()) {
                                  cubit.loginUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              });
                        },
                        fallback: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Text(
                              'don\'t have an account',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey[800]),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterShopAppScreen());
                              },
                              child: const Text(
                                'register now',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: defultColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

var emailController = TextEditingController();
var passwordController = TextEditingController();
var formKey = GlobalKey<FormState>();

import 'package:first_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/modules/shop_app/login_screen/loginScreen.dart';
import 'package:first_app/modules/shop_app/products_page/productsScreen.dart';
import 'package:first_app/modules/shop_app/search_screen/searchScreen.dart';
import 'package:first_app/network/locale/cashHelper.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, ShopSearchScreen());
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    color: defultColor,
                  )),
              SizedBox(
                width: 10,
              )
            ],
            title: const Text('Shop App'),
            titleTextStyle: TextStyle(
                color: defultColor, fontSize: 20, fontWeight: FontWeight.w900),
          ),
          bottomNavigationBar: bottmNavBar(cubit),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}

Widget bottmNavBar(ShopCubit cubit) {
  // ignore: prefer_const_literals_to_create_immutables
  return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: cubit.currentIndex,
      onTap: (value) {
        cubit.currentIndex = value;
        cubit.changeNav();
      },
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        const BottomNavigationBarItem(icon: Icon(Icons.apps), label: ''),
        const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        const BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
      ]);
}


// TextButton(
//         onPressed: () {
//           CashHelper.removeDate(key: 'token').then((value) {
//             if (value == true) {
//               navigateAndFinsh(context, LoginShopApp());
//             }
//           });
//         },
//         child: Text('logout'),
//       ),
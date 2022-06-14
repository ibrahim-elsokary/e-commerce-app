import 'package:first_app/modules/shop_app/login_screen/loginScreen.dart';
import 'package:first_app/network/locale/cashHelper.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  onSubmit(context);
                });
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  'Skip',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: PageView.builder(
                onPageChanged: (value) {
                  if (value == boardingModel.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) =>
                    buildOnBoarding(index: index, model: boardingModel),
                itemCount: boardingModel.length,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: boardingModel.length,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        expansionFactor: 2,
                        activeDotColor: defultColor),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        setState(() {
                          onSubmit(context);
                        });
                      } else {
                        pageController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.ease);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ),
          ),
          // const SizedBox(
          //   height: 30,
          // ),
        ],
      ),
    );
  }
}

bool isLast = false;
var pageController = PageController();
Widget buildOnBoarding(
    {required int index, required List<BoardingModel> model}) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 400,
          child: Center(
              child: SvgPicture.asset(
            model[index].image,
            fit: BoxFit.fitWidth,
          )),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          model[index].title,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          model[index].bodyText,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ],
    ),
  );
}

class BoardingModel {
  final String image;
  final String title;
  final String bodyText;
  BoardingModel(
      {required this.image, required this.title, required this.bodyText});
}

List<BoardingModel> boardingModel = [
  BoardingModel(
      image: 'assets/images/Ecommerce campaign-rafiki.svg',
      title: 'Screen one',
      bodyText: 'Screen body one'),
  BoardingModel(
      image: 'assets/images/Opened-pana.svg',
      title: 'Screen tow',
      bodyText: 'Screen body tow'),
  BoardingModel(
      image: 'assets/images/People buying school supplies-amico.svg',
      title: 'Screen three',
      bodyText: 'Screen body three'),
];

void onSubmit(context) {
  CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
    if (value == true) {
      navigateAndFinsh(context, LoginShopApp());
    }
  });
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/models/shopModels/shopHomeModel.dart';
import 'package:first_app/models/shopModels/shop_category_model.dart';
import 'package:first_app/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
              ShopCubit.get(context).shopCategoryModel?.data?.data != null &&
                  ShopCubit.get(context).shopHomeModel?.data?.products != null,
          builder: (context) =>
              ProductsBuilder(ShopCubit.get(context).shopHomeModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget ProductsBuilder(ShopHomeModel? model, context) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model?.data?.banners
                ?.map((e) => Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          '${e.image}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              reverse: false,
              initialPage: 0,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayInterval: Duration(seconds: 5),
            )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 140,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCat(
                        ShopCubit.get(context)
                            .shopCategoryModel
                            ?.data
                            ?.data?[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                    itemCount: 5),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Text(
                  'New Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: GridView.count(
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 1 / 1.3,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(model!.data!.products!.length,
                (index) => buildProduct(model.data!.products![index], context)),
          ),
        )
      ],
    ),
  );
}

Widget buildProduct(ShopHomeModelDataProducts model, context) {
  return Container(
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.all(2),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: Column(
      children: [
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Image.network(
                '${model.image}',
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.only(left: 8, top: 2),
                  color: Colors.red,
                  child: const Text(
                    'Discount',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${model.title}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${model.price}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: defultColor),
                ),
              ),
              if (model.discount != 0)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    '${model.oldPrice}',
                    style: TextStyle(
                        textBaseline: TextBaseline.alphabetic,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
              Spacer(),
              IconButton(
                  focusColor: Colors.red,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    ShopCubit.get(context).changeFav(model.id!);
                  },
                  icon: Icon(
                    Icons.favorite_rounded,
                    color: ShopCubit.get(context).fav![model.id]!
                        ? Colors.red
                        : Colors.grey,
                  )),
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildCat(ShopCategoryDataOfDataModel? model) {
  return Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(15)),
    width: 100,
    height: 120,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Image.network(
            '${model?.image}',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              '${model?.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    ),
  );
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/models/shopModels/search_model.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearchScreen extends StatelessWidget {
  const ShopSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultFormField(
                    context,
                    controller: searchController,
                    type: TextInputType.text,
                    hint: 'Search Here',
                    prefixcIcon: Icon(Icons.search_rounded),
                    validator: (String? val) {
                      if (kDebugMode) {
                        print(val);
                      }
                      if (val!.isEmpty) {
                        return ' Please Enter Text  ';
                      }
                    },
                    onChanged: (value) {
                      ShopCubit.get(context).getSearchData(data: value);
                    },
                    onFaildSubmitted: (value) {
                      searchController.clear();
                    },
                  ),
                ),
                Expanded(
                    child: ConditionalBuilder(
                  condition: state is ShopGetSearchSuccessState,
                  builder: (context) => ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildSearchItem(
                          ShopCubit.get(context)
                              .shopSearchModel
                              ?.data
                              .data[index],
                          context),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                      itemCount: ShopCubit.get(context)
                          .shopSearchModel!
                          .data
                          .data
                          .length),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}

var formKey = GlobalKey<FormState>();
var searchController = TextEditingController();
Widget buildSearchItem(ShopSearchModelDataOfData? model, context) {
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    height: 100,
    decoration: BoxDecoration(
        color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 90,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              ' ${model?.title}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: FloatingActionButton(
            mini: true,
            onPressed: () {
              ShopCubit.get(context).changeFav(model!.id);
            },
            child: Icon(
              Icons.favorite_rounded,
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}

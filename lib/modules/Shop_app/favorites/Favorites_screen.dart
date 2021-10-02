import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/Cubit/Cubit.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/Cubit/states.dart';
import 'package:udemy_flutter_1/modules/Shop_app/favorites/Get_Favorites_Model.dart';
import 'package:udemy_flutter_1/modules/Shop_app/products/ShopProductsModule.dart';

class favoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context , state) {},
      builder: (context , state) {


        return ConditionalBuilder(
            condition: true,
            builder: (context) => ProductsBuilder(ShopCubit.get(context).GetFavoritesModel! ,context),
            fallback:(context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget ProductsBuilder(getFavoritesModel model,context) => Container(
    child: GridView.count(
      shrinkWrap: true,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: 1 / 1.35,
        crossAxisCount: 2,
    children:
      List.generate(model.data.data.length, (index) =>
          builderGridProduct(model.data.data[index], context),
      ),
    ),
  );

  Widget builderGridProduct(FavoritesData model , context)
  {
    ShopCubit Cubit = ShopCubit.get(context);
    return Column(
        children: [
          Container(
            color: Colors.white,
            child:Image(
                image:NetworkImage(model.product.image),
              width: double.infinity,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 5, start: 5, end: 5,),
            child: Text(
              model.product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                height: 1.1,
              ),
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(onPressed: () {
                  ShopCubit.get(context).changeFavorites(model.id);
                  print('product Id: ' + '${model.id}');
                  // showToast(
                  //   text: ShopCubit
                  //       .get(context)
                  //       .ChangeFavorites!
                  //       .message
                  //       .toString(),
                  //   state: ToastStates.SUCCESS,
                  // );
                },
                  icon: Icon(Cubit.favorites[model.id] == true
                      ? Cubit.FavIcon = Icons.favorite
                      : Cubit.FavIcon = Icons.favorite_border, size: 18,
                  ),
                ),
              ),
              Container(
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(3.0,),
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Text(
                        '${model.product.price.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${model.product.old_price.round()}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  }

}

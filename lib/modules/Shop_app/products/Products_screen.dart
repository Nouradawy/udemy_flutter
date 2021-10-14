import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/Cubit/Cubit.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/Cubit/states.dart';
import 'package:udemy_flutter_1/components/Companents.dart';
import 'package:udemy_flutter_1/components/constants.dart';
import 'package:udemy_flutter_1/modules/Shop_app/categories/categoriesModule.dart';
import 'ShopProductsModule.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ShopCubit()..getHomeData()..getFavoritesData()..getCategoriesData()..postRegisterdData()..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit
                  .get(context)
                  .homeModel != null,
              builder: (context) {
                ShopCubit Cubit = ShopCubit.get(context);
                return ProductsBuilder(Cubit.homeModel!, context);
              },
              fallback: (context) => Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }

  // ADD-LIST-TO-LIST: New list for adding values from it and indexing it .
  List imagelist = [
    "https://media-exp1.licdn.com/dms/image/C4E1BAQGENeCDJ5VXPg/company-background_10000/0/1559151958971?e=2159024400&v=beta&t=aVOx6JocN4tZFBf4ssICncreN4NSR3X86Btrn_WtTbk",
    "https://cdn.shopify.com/s/files/1/0412/8728/6937/collections/electronic-gadgets_1200x1200.jpg?v=1592481285",
    "https://media-exp1.licdn.com/dms/image/C4E1BAQGENeCDJ5VXPg/company-background_10000/0/1559151958971?e=2159024400&v=beta&t=aVOx6JocN4tZFBf4ssICncreN4NSR3X86Btrn_WtTbk",
    "https://cdn.shopify.com/s/files/1/0412/8728/6937/collections/electronic-gadgets_1200x1200.jpg?v=1592481285",
  ];


  Widget ProductsBuilder(HomeModel model, context) {
    ShopCubit Cubit = ShopCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners.map((element) =>
                Image(
                  image: NetworkImage('${element.image}'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
            ).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categoreis' ,style: TextStyle(fontSize: 17),),
                Container(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics:BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildCategoryItem(context,index),
                      separatorBuilder: (context, index) => SizedBox(width: 3),
                      itemCount:Cubit.categoriesModel!.data!.data.length,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Featured products',style: TextStyle(fontSize: 17),),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.35,
              children: List.generate(model.data.products.length, (index) =>
                  buildeGridProduct(model.data.products[index], context),

              ),
            ),
          ),
        ],
      ),
    );
  }

 Stack buildCategoryItem(context,index) =>
      Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imagelist[index]),
            ),
          ),
        ),
        Container(
          width: 100,
          color: Colors.white.withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              '${ShopCubit.get(context).categoriesModel?.data?.data[index].name}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ]);

  Widget buildeGridProduct(ProductModel model, context) {
    ShopCubit Cubit = ShopCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          color: Colors.white,
          child: Image(
            image: NetworkImage(model.image),
            width: double.infinity,
            height: 200,
            // fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 5, start: 5, end: 5,),
          child: Text(
            model.name,
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
                      '${model.price.round()}',
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
                      '${model.oldPrice.round()}',
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
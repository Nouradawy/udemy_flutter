import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/Cubit/Cubit.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/Cubit/states.dart';
import 'package:udemy_flutter_1/components/Companents.dart';
import 'package:udemy_flutter_1/modules/Shop_app/categories/categoriesModule.dart';


class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {},
      builder: (context, state) {
        ShopCubit Cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition:Cubit.categoriesModel != null,
            builder: (context) {return ListView.separated(
            separatorBuilder: (context , index ) =>myDivider(),
            itemCount: Cubit.categoriesModel!.data!.data.length,
            itemBuilder: (context , index) => buildCategories(Cubit.categoriesModel!.data!.data[index] , context , index++), // ADD-LIST-TO-LIST: Declaring a new value Named index++ to increment it's value
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator())
        );
      },
    );

  }
// ADD-LIST-TO-LIST: New list for adding values from it and indexing it .
  List imagelist = [
    "https://media-exp1.licdn.com/dms/image/C4E1BAQGENeCDJ5VXPg/company-background_10000/0/1559151958971?e=2159024400&v=beta&t=aVOx6JocN4tZFBf4ssICncreN4NSR3X86Btrn_WtTbk",
    "https://cdn.shopify.com/s/files/1/0412/8728/6937/collections/electronic-gadgets_1200x1200.jpg?v=1592481285",
    "https://media-exp1.licdn.com/dms/image/C4E1BAQGENeCDJ5VXPg/company-background_10000/0/1559151958971?e=2159024400&v=beta&t=aVOx6JocN4tZFBf4ssICncreN4NSR3X86Btrn_WtTbk",
    "https://cdn.shopify.com/s/files/1/0412/8728/6937/collections/electronic-gadgets_1200x1200.jpg?v=1592481285",
  ];

  Widget buildCategories(CategoriesData model , context , index) => Padding(          // ADD-LIST-TO-LIST: By using index value to get the index that going to be used into the imagelist[index]
    padding: const EdgeInsets.symmetric(horizontal: 35.0 , vertical: 15),
    child: Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: (){

              },
              child: Container(
                width: 85.0,
                height: 85.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black38, width: 3,),
                  image:DecorationImage(
                    image:NetworkImage(imagelist[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 35.0,),
            Expanded(child: Text(model.name)),
            Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))),
          ],
        ),
        ],
    ),
  );


}

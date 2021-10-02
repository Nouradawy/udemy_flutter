import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Network/local/cache_helper.dart';
import 'package:udemy_flutter_1/components/constants.dart';
import 'package:udemy_flutter_1/modules/Shop_app/search/Search_screen.dart';

import 'Cubit/Cubit.dart';
import 'Cubit/states.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (state, context) => {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                  onPressed: () {
                    SignOut(context);
                  },
                  icon: Icon(Icons.account_circle),),
              IconButton(
                  onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SearchScreen()));
                },
                  icon: Icon(Icons.search),),
            ],
          ),
          body:ShopCubit.get(context).bottomScreens[ShopCubit.get(context).CurrentIndex],

          bottomNavigationBar: BottomNavigationBar(
            onTap:(index)
              {
                ShopCubit.get(context).changeBottom(index);
              },
            currentIndex:ShopCubit.get(context).CurrentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label:'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label:'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label:'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label:'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

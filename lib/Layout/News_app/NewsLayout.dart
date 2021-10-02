import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Layout/News_app/cubit/cubit.dart';
import 'package:udemy_flutter_1/Layout/News_app/cubit/states.dart';
import 'package:udemy_flutter_1/Layout/Todo_app/cubit/cubit.dart';
import 'package:udemy_flutter_1/Layout/Todo_app/cubit/states.dart';
import 'package:udemy_flutter_1/Network/remote/dio_helper.dart';
import 'package:udemy_flutter_1/modules/News_app/Search/Search.dart';



class NewsLayout extends StatelessWidget {

  @override
  Widget build (BuildContext context) {
     return BlocConsumer<NewsCubit, NewsStates>(
       listener:(context, state){},
       builder: (context, state){
         NewsCubit Cubit = NewsCubit.get(context);
         return Scaffold(
           appBar: AppBar(
             title:Text('News App'),
             actions: [
               IconButton(
                 onPressed: (){
                   Navigator.push(context,
                   MaterialPageRoute(builder: (BuildContext context) =>SearchScreen()));
                 },
                 icon: Icon(Icons.search),
               ),
               IconButton(
                   onPressed: (){
                     AppCubit.get(context).changeAppMode();
                   },
                   icon: Icon(Icons.brightness_4_outlined),
               ),
             ],
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(5.0,),
             ),
           ),
           body: Cubit.Screens[Cubit.CurrentIndex],
           bottomNavigationBar: BottomNavigationBar(
               type: BottomNavigationBarType.fixed,
               currentIndex: Cubit.CurrentIndex,
               onTap: (index) {
                 Cubit.ChangeIndex(index);
               },
               items: [
                 BottomNavigationBarItem(icon: Icon(Icons.business),
                 label: 'Business'),
                 BottomNavigationBarItem(icon: Icon(Icons.sports_cricket),
                 label:'Sports'),
                 BottomNavigationBarItem(icon: Icon(Icons.science_outlined,),
                 label:'Science'),
               ])


         );
       },
     );
  }
}

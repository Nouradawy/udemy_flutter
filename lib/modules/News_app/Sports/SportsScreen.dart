import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Layout/News_app/cubit/cubit.dart';
import 'package:udemy_flutter_1/Layout/News_app/cubit/states.dart';
import 'package:udemy_flutter_1/components/Companents.dart';

class SportsScreen extends StatefulWidget {

  @override
  _SportsScreenState createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context, state){} ,
      builder: (context, state){
        NewsCubit Cubit = NewsCubit.get(context);
        return ConditionalBuilder(
          condition: Cubit.Sports.length > 0,
          builder: (context) =>  ListView.separated(
              itemBuilder: (context,index) => buildArticleItem(Cubit.Sports[index],context),
              separatorBuilder: (context,index)=> myDivider(),
              itemCount: 10,),
          fallback:(context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

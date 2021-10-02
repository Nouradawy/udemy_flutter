import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Layout/News_app/cubit/cubit.dart';
import 'package:udemy_flutter_1/Layout/News_app/cubit/states.dart';
import 'package:udemy_flutter_1/components/Companents.dart';

class BusniessScreen extends StatefulWidget {


  @override
  _BusniessScreenState createState() => _BusniessScreenState();
}

class _BusniessScreenState extends State<BusniessScreen> {
  @override
  Widget build(BuildContext context) {
    NewsCubit Cubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! NewsGetBusinessLoadingState,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildArticleItem(Cubit.business[index],context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: 10,),
            fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Layout/News_app/cubit/cubit.dart';
import 'package:udemy_flutter_1/Layout/News_app/cubit/states.dart';
import 'package:udemy_flutter_1/components/Companents.dart';



class SearchScreen extends StatelessWidget {
  var SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context, state){} ,
      builder: (context, state)
      {
        NewsCubit Cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left:15.0,
                  right:15.0,
                  top:2.0,),
                child: defaultTextForm(context,
                  controller: SearchController,
                  keyBoardType: TextInputType.text,
                  text: 'Search',
                  onTap: (){},
                  validate:(value){},
                  onChang: (value){
                    Cubit.getSearch(value!);
                  },
                  AutoFocus: true,
                  SuffixIcon: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(Cubit.Search, context)),
            ],
          ),

        );

      },
    );
  }
}

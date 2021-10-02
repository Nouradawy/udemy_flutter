import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Layout/News_app/cubit/states.dart';
import 'package:udemy_flutter_1/Network/remote/dio_helper.dart';
import 'package:udemy_flutter_1/modules/News_app/Busniess/BusniessScreen.dart';
import 'package:udemy_flutter_1/modules/News_app/Science/ScienceScreen.dart';
import 'package:udemy_flutter_1/modules/News_app/Search/Search.dart';
import 'package:udemy_flutter_1/modules/News_app/SettingsScreen/WebViewScreen.dart';
import 'package:udemy_flutter_1/modules/News_app/Sports/SportsScreen.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;

  List <Widget> Screens =
  [
    BusniessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SearchScreen(),
  ];


  void ChangeIndex(int index)
  {
    CurrentIndex = index;
    index==1? getSports():null;
    index==2? getScience():null;
    emit(NewsBottomNavState());
  }
  List<dynamic> business = [];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country':'eg',
      'category':'business',
      'apiKey':'176263d2faa248e9aafb7d7633d6ebf4',
    },
    ).then((value) {
      // print(value.data['articles']);
      business = value.data['articles'];
      // print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> Sports = [];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(Sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '176263d2faa248e9aafb7d7633d6ebf4',
        },
      ).then((value) {
        // print(value.data['articles']);
        Sports = value.data['articles'];
        print(Sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else emit(NewsGetSportsSuccessState());
  }

  List<dynamic> Science = [];
  void getScience()
  {
    emit(NewsGetSportsLoadingState());

    if(Science.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '176263d2faa248e9aafb7d7633d6ebf4',
        },
      ).then((value) {
        // print(value.data['articles']);
        Science = value.data['articles'];
        print(Science[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else emit(NewsGetSportsSuccessState());
  }

  List<dynamic> Search = [];
  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '176263d2faa248e9aafb7d7633d6ebf4',
        },
      ).then((value) {
        // print(value.data['articles']);
        Search = value.data['articles'];
        print(Search[0]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });

  }


  bool isDark = false;

  void changeAppMode()
  {
    isDark = !isDark;
    emit(AppChangeModeState());
  }

}

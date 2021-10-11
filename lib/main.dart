
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:udemy_flutter_1/Layout/News_app/cubit/cubit.dart';
import 'package:udemy_flutter_1/Layout/News_app/cubit/states.dart';
import 'package:udemy_flutter_1/Network/local/cache_helper.dart';
import 'package:udemy_flutter_1/Network/remote/dio_helper.dart';
import 'package:udemy_flutter_1/components/constants.dart';
import 'package:udemy_flutter_1/counter/counter_screen.dart';
import 'package:udemy_flutter_1/modules/Shop_app/on_boarding/on_boarding_screen.dart';
import 'Layout/News_app/NewsLayout.dart';
import 'Layout/Shop_app/Cubit/Cubit.dart';
import 'Layout/Shop_app/ShopLayout.dart';
import 'Layout/Todo_app/cubit/cubit.dart';
import 'Layout/Todo_app/cubit/states.dart';
import 'Layout/Todo_app/home_layout.dart';
import 'login_screen.dart';
import 'modules/News_app/SettingsScreen/WebViewScreen.dart';
import 'modules/Shop_app/Login/ShopLoginScreen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.dio;
  await cacheHelper.init();
  bool? isDark = cacheHelper.getData(key: 'isDark');
  bool? onBoarding = cacheHelper.getData(key: 'onBoarding');
  token = cacheHelper.getData(key: 'token');
  print("AuthorizationToken: "+token.toString());
  Widget homescreen = ShopLayout();
  if(onBoarding != null)
    {
      if(token != null) homescreen = ShopLayout();
      else homescreen = ShopLoginScreen();
    } else homescreen = OnBoardingScreen();



  runApp(MyApp(
    isDark: isDark == null?isDark==null:isDark,
    HomeScreen: homescreen ,

  ));
}

class MyApp extends StatelessWidget
{
  final bool isDark;
  // final bool OnBoarding;
  final Widget HomeScreen;
  MyApp({
    required this.isDark,
    // required this.OnBoarding,
    required this.HomeScreen,
});
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers:[
        BlocProvider(
            create: (context)=>AppCubit()..changeAppMode(
        fromShared: isDark,
      ),),
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness(),),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getFavoritesData()..getCategoriesData(),),
      ],
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context, state){},
        builder:(context ,state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              elevation: 20.0,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            fontFamily: 'jannah',
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: HexColor('333739'),
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: HexColor('333739'),
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: HexColor('333739'),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            fontFamily: 'jannah',
          ),
          // themeMode: AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
          themeMode: ThemeMode.light,
          debugShowMaterialGrid: false,
          home: HomeScreen,
        );
      },
      ),
    );

  }

}
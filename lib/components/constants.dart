import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter_1/Network/local/cache_helper.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Login/Cubit/Cubit.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Login/ShopLoginScreen.dart';



class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

void SignOut(context) {
  cacheHelper.DeleteData(key: 'token').then(
    (value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ShopLoginScreen()),
          (Route<dynamic> route) => false,
        );
      }
    },
  );
}

String? token ;



// class PasswordVisibility{
//   bool isPassword;
//   IconData? suffixIcon;
//
//   PasswordVisibility({
//     this.isPassword = true,
//     this.suffixIcon = Icons.visibility,}
//   ){
//     isPassword =! isPassword!;
//     suffixIcon == isPassword ?Icons.visibility:Icons.visibility_off;
//     ShopLoginCubit.get(context).Passon();
//   }

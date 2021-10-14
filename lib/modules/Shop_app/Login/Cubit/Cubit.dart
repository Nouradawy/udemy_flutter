import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Network/Endpoints.dart';
import 'package:udemy_flutter_1/Network/remote/dio_helper.dart';
import 'package:udemy_flutter_1/components/constants.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Login/Cubit/states.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Login/loginmodel.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? LoginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      LoginModel = ShopLoginModel.fromjson(value.data);

      // print(LoginModel!.message);
      // print(LoginModel!.status);
      token = LoginModel?.data?.token;
      emit(ShopLoginSuccessState(LoginModel!));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }


  bool isPassword = true;
  IconData? suffixIcon = Icons.visibility;
  void Passon(){
    isPassword =! isPassword;
    suffixIcon = isPassword ?Icons.visibility:Icons.visibility_off;
    emit(ShopIsPasswordState());
  }

}

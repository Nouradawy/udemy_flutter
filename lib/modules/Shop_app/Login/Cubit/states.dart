import '../loginmodel.dart';

abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginSuccessState extends ShopLoginState{

  final ShopLoginModel LoginModel;

  ShopLoginSuccessState(this.LoginModel);

}

class ShopLoginErrorState extends ShopLoginState
{
final String error;
ShopLoginErrorState(this.error);
}

class ShopIsPasswordState extends ShopLoginState{}
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/Cubit/states.dart';
import 'package:udemy_flutter_1/Network/Endpoints.dart';
import 'package:udemy_flutter_1/Network/remote/dio_helper.dart';
import 'package:udemy_flutter_1/components/constants.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Login/loginmodel.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Register/RegisterModel.dart';
import 'package:udemy_flutter_1/modules/Shop_app/categories/CategoriesScreen.dart';
import 'package:udemy_flutter_1/modules/Shop_app/categories/categoriesModule.dart';
import 'package:udemy_flutter_1/modules/Shop_app/favorites/Change_Favorites_Model.dart';
import 'package:udemy_flutter_1/modules/Shop_app/favorites/Favorites_screen.dart';
import 'package:udemy_flutter_1/modules/Shop_app/favorites/Get_Favorites_Model.dart';
import 'package:udemy_flutter_1/modules/Shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udemy_flutter_1/modules/Shop_app/products/Products_screen.dart';
import 'package:udemy_flutter_1/modules/Shop_app/products/ShopProductsModule.dart';
import 'package:udemy_flutter_1/modules/Shop_app/settings/Settings_screen.dart';




class ShopCubit extends Cubit<ShopStates>
{

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel ;
  CategoriesModel? categoriesModel;
  ChangeFavoritesModel? ChangeFavorites;
  getFavoritesModel? GetFavoritesModel;
  ShopLoginModel? shopLoginModel;
  RegisterModel? registerModel;
  String? Textout;
  int CurrentIndex = 0;

List<Widget> bottomScreens = [
  ProductsScreen(),
  CategoriesScreen(),
  favoritesScreen(),
  SettingsScreen(),
];

void changeBottom(int index)
{
  CurrentIndex = index;
  emit(ShopChangeBottomNavState());
}


  Map<int,bool> favorites={};
  IconData? FavIcon;
  Map<String,dynamic> Register = {};

  void getHomeData() {

    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token:token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel?.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorites
        });

      });
      emit(ShopSuccessHomeDataState());

    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  void getCategoriesData() {


    emit(ShopLoadingCategoriesDataState());

    DioHelper.getData(
      url: Categories,
      token:token,
    ).then((value) {
      categoriesModel = CategoriesModel.formJson(value.data);



      emit(ShopSuccessCategoriesState());

    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoreisState());
    });
  }

  void changeFavorites(int productId)
  {
    if(favorites[productId] == true) {
      favorites[productId] = false;
      FavIcon = Icons.favorite;
    }
    else {
      favorites[productId] = true;
      FavIcon = Icons.favorite_border;
    }


    emit(ShopChangeFavorietsState());

    DioHelper.postData(url: FAVORITES,
      data:
      {
        'product_id' : productId,
      },
      token: token,
    ).then((value) {
      ChangeFavorites = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      getFavoritesData();

      if(!ChangeFavorites!.status!){
        if(favorites[productId] == true) {
          favorites[productId] = false;
          FavIcon = Icons.favorite;
        }
        else {
          favorites[productId] = true;
          FavIcon = Icons.favorite_border;
        }
      }

      emit(ShopSuccessChangeFavorietsState(ChangeFavorites!));
    }
    ).catchError((error){

      if(favorites[productId] == true) {
        favorites[productId] = false;
        FavIcon = Icons.favorite;
      }
      else {
        favorites[productId] = true;
        FavIcon = Icons.favorite_border;
      }

      emit(ShopErrorChangeFavorietsState());
    });
    
  }

  void getFavoritesData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: FAVORITES,
      token:token,
    ).then((value) {
      GetFavoritesModel = getFavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());

    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavorietsState());
    });
  }

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromjson(value.data);

      emit(ShopSuccessUserState(shopLoginModel!));

    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserState());
    });
  }

  void postRegisterdData({String? name , String? email , String? phone , String? password}) {

    emit(ShopLoadingPostRegisterDataState());
    Textout = "We are trying to Register your data into our data base";
    DioHelper.postData(
      url: REGISTER,
      data: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);

      emit(ShopSuccessPostRegisterDataState());
      Textout = "Setback and relax while we Trying to sign you in";


    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorPostRegisterDataState());
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

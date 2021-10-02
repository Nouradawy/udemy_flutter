import 'package:udemy_flutter_1/modules/Shop_app/favorites/Change_Favorites_Model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopSuccessChangeFavorietsState extends ShopStates
{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavorietsState(this.model);
}
class ShopChangeFavorietsState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopErrorCategoreisState extends ShopStates{}
class ShopErrorChangeFavorietsState extends ShopStates{}
class ShopErrorGetFavorietsState extends ShopStates{}



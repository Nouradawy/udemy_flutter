class ShopSearchModel{
  bool? status;
  Null message;
  ShopSearchData? data;

  ShopSearchModel.fromJson(Map<String , dynamic> json)
  {
    data = json['data'] != null ? new ShopSearchData.fromJson(json['data']) : null;
  }
}

class ShopSearchData{
  List<ShopSearchProduct> data=[];

  ShopSearchData.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element) {
      data.add(new ShopSearchProduct.fromJson(element));
    });

  }
}

class ShopSearchProduct{
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? in_favorites;
  bool? in_cart;

  ShopSearchProduct.fromJson(Map<String,dynamic> json){

    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
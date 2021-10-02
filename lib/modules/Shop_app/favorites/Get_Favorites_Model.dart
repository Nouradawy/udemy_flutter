class getFavoritesModel
{
  late bool status;
  late Null message;
  late DataFav data;

  getFavoritesModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    message = json['message'];
    data = DataFav.fromJson(json['data']);
  }
}

class DataFav
{

  late int currentPage;
  List<FavoritesData> data=[];
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  late Null nextPageUrl;
  late String path;
  late int perPage;
  late Null prevPageUrl;
  late int to;
  late int total;

  DataFav.fromJson(Map<String,dynamic>json)
  {
    currentPage = json['current_page'];

      json['data'].forEach((element) {
        data.add(FavoritesData.fromJson(element));
      });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
    }

}


class FavoritesData{
  late int id;
  late Product product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = (json['product'] != null ? new Product.fromJson(json['product']) : null)!;
  }
}
class Product{
  late int id;
  dynamic price;
  dynamic old_price;
  late int discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}

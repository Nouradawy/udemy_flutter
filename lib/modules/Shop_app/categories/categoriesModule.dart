class CategoriesModel
{
  late bool status;
  CategoriesPageData? data;

  CategoriesModel.formJson(Map<String,dynamic>json)
  {
    status = json['status'];
    data = json['data'] != null ? new CategoriesPageData.fromJson(json['data']) : null;
  }
}

class CategoriesPageData{

  late int currentPage;
  late String firstPageurl;
  late int from;
  late int LastPage;
  late String LastPageurl;
  late String Path;
  late int PerPage;
  late int total;
  List<CategoriesData> data =[];

  CategoriesPageData.fromJson(Map<String,dynamic> json)
  {
    currentPage = json["current_page"];
    firstPageurl = json["first_page_url"];
    from = json["from"];
    LastPage = json["last_page"];
    LastPageurl = json["last_page_url"];
    Path = json["path"];
    PerPage = json["per_page"];
    total = json["total"];
    json['data'].forEach((element)
    {
        data.add(CategoriesData.fromJson({
          'name': element['name'],
          'id': element['id'],
          'image' : element['image'],
        }));
    });
    ///* ADD-LIST-TO-LIST: Using this method to add only keys from the Json libery
    /// keys : value

  }
}

class CategoriesData{
  late int id;
  late String name;
  late String image;

  CategoriesData.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }


}
class CategoriesModel
{
  late bool status;
  late CategoriesPageData data;

  CategoriesModel.formJson(Map<String,dynamic>json)
  {
    status = json['status'];
    data = CategoriesPageData.fromJson(json['data']);
  }
}

class CategoriesPageData{

  late int currentPage;
  late String firstPageurl;
  late int from;
  late int LastPage;
  late String LastPageurl;
  late String NextPageurl;
  late String Path;
  late int PerPage;
  late String PrevPaageurl;
  late int total;
  List<CategoriesData> data =[];

  CategoriesPageData.fromJson(Map<String,dynamic> json)
  {
    currentPage = json["current_page"];
    firstPageurl = json["first_page_url"];
    from = json["from"];
    LastPage = json["last_page"];
    LastPageurl = json["last_page_url"];
    NextPageurl = json["next_page_url"];
    Path = json["path"];
    PerPage = json["per_page"];
    PrevPaageurl = json["prev_page_url"];
    total = json["total"];
    json['data'].forEach((element)
    {
      data.add(CategoriesData.fromJson(json['data']));
    });

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
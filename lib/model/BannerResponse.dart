
class BannerResponse {
  int code = 0;
  String msg = "";

  Data data = Data();



  BannerResponse.fromJson(Map<String,dynamic> json){
    code = json['code'];
    msg = json['msg'];

    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }

  }

}

class Data {
  Data();

  List<BannerInfo> list;

  Data.fromJson(Map<String,dynamic> json){

    dynamic subjectItems = json['list'];
    if (subjectItems != null && subjectItems is List) {
      list = [];
      subjectItems.forEach((subjectModel){
        list.add(BannerInfo.fromJson(subjectModel));
      });
    }

  }
}

class BannerInfo {
  String title;
  String url_link;
  String img_url;

  BannerInfo.fromJson(Map<String,dynamic> json) {
    if (json != null) {
      title = json['title'];
      url_link = json['url_link'];
      img_url = json['img_url'];
    }
  }
}
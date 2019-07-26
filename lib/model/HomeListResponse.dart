
class HomeListResponse {
  int code = 0;
  String msg = "";


  Data data = Data();


  HomeListResponse.fromJson(Map<String,dynamic> json){
    code = json['code'];
    msg = json['msg'];

    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }

  }

}

class Data {
  Data();

  List<HomeListInfo> data;

  Data.fromJson(Map<String,dynamic> json){

    dynamic subjectItems = json['data'];
    if (subjectItems != null && subjectItems is List) {
      data = [];
      subjectItems.forEach((subjectModel){
        data.add(HomeListInfo.fromJson(subjectModel));
      });
    }

  }

}


class HomeListInfo {
  String salary_unit;
  String distance;
  String company_sort_name;
  String company_logo;
  String job_img;
  int height;
  int width;
  String in_a_word;
  String salary;

  HomeListInfo.fromJson(Map<String,dynamic> json) {
    if (json != null) {
      salary_unit = json['salary_unit'];
      distance = json['distance'];
      company_sort_name = json['company_sort_name'];
      company_logo = json['company_logo'];
      job_img = json['job_img'];
      height = json['height'];
      width = json['width'];
      in_a_word = json['in_a_word'];
      salary = json['salary'];
    }
  }
}
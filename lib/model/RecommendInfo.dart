
class RecommendInfo {
  int code = 0;
  String msg = "";
  String balance;
  Data data = Data();

  RecommendInfo.fromJson(Map<String, dynamic> json){
    code = json['code'] as int;
    msg = json['msg'] as String;
    balance = json['balance'] as String;
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
  }


}

class Data {
  Data();

  List<Info> list;

  Data.fromJson(Map<String, dynamic> json) {
    dynamic subjectItems = json['data'];
    if (subjectItems != null && subjectItems is List) {
      list = [];
      subjectItems.forEach((subjectModel) {
        list.add(Info.fromJson(subjectModel));
      });
    }
  }
}

class Info {
  Info();
  String user_mobile;
  String registered_at;
  String interviewed_at;
  String is_rewarded;

  Info.fromJson(Map<String,dynamic> json) {
    if (json != null) {
      user_mobile = json['user_mobile'];
      registered_at = json['registered_at'];
      interviewed_at = json['interviewed_at'];
      is_rewarded = json['is_rewarded'];
    }
  }
}
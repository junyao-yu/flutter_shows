class MyInviter {
  int code = 0;
  String msg = "";
  Data data;

  MyInviter.fromJson(Map<String, dynamic> json) {
    code = json['code'] as int;
    msg = json['msg'] as String;
    if (json['data'] != null && json.length > 0) {
      data = Data.fromJson(json['data']);
    }
  }
}

class Data {
  Data();

  var invited_id = 0;
  var invited_name = "";
  var invited_mobile = "";

  Data.fromJson(Map<String, dynamic> json) {
    if (json != null && json.length > 0) {
      invited_id = json['invited_id'];
      invited_name = json['invited_name'];
      invited_mobile = json['invited_mobile'];
    }
  }
}

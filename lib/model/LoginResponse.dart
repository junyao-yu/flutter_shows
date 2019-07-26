class LoginResponse {
  int code = 0;
  String msg = "";

  Data data = Data();

  LoginResponse.fromJson(Map<String, dynamic> json) {
      code = json['code'] as int;
      msg = json['msg'] as String;

      if (json['data'] != null) {
        data = Data.fromJson(json['data']);
      }

  }

}

class Data {

  Data();

  String token = "";

  Data.fromJson(Map<String, dynamic> json) {
     token = json['token'] as String;
  }
}
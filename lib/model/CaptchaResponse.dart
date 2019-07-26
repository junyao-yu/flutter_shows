import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CaptchaResponse {

  int code = 0;
  String msg = "";

  CaptchaResponse.fromJson(Map<String, dynamic> json) {
      code = json['code'];
      msg = json['msg'] as String;
  }

}
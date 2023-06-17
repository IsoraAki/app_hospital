import 'package:my_app_hospital/app/network/data/model/base_model.dart';

class ErrorResponse extends BaseResponse {
  ErrorResponse({
    this.errMessage,
    this.rule,
    this.attribute,
  });
  String? errMessage;
  String? rule;
  String? attribute;

  factory ErrorResponse.fromMap(Map<String, dynamic> json) => ErrorResponse(
        errMessage: json["message"] == null ? '' : json["message"],
        rule: json["rule"] == null ? '' : json["rule"],
        attribute: json["attribute"] == null ? '' : json["attribute"],
      );
}

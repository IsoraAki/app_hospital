class MyResponse<T> {
  bool? success;
  int? statusCode;
  String? code;
  List<String>? message;
  String? error;
  List<T>? data;
  List<T>? result;

  MyResponse(
    this.success,
    this.statusCode,
    this.code,
    this.message,
    this.error,
    this.data,
    this.result,
  );

  MyResponse.fromJson(Map<String, dynamic> json, BaseObject? target)
      : success = json["Success"] ?? false,
        statusCode = json["statusCode"] ?? 0,
        code = json["code"] ?? '',
        //message = json['message'].cast<String>() ?? [],
        message = target == null
            ? ((json["message"] is int || json["message"] is double)
                ? [json["message"]]
                : (json["message"] is Map ? List<T>.from([Map<String, dynamic>.from(json["message"])]) : json["message"]))
            : json.containsKey("message")
                ? ((json["message"] is Map)
                    ? List<T>.from([target.fromJson(Map<String, dynamic>.from(json["message"]))])
                    : List<T>.from(json["message"].map((i) => (target).fromJson(i))))
                : [],
        error = json["error"] ?? '',
        result = target == null
            ? ((json["Result"] is int || json["Result"] is double)
                ? [json["Result"]]
                : (json["Result"] is Map ? List<T>.from([Map<String, dynamic>.from(json["Result"])]) : json["Result"]))
            : json.containsKey("Result")
                ? ((json["Result"] is Map)
                    ? List<T>.from([target.fromJson(Map<String, dynamic>.from(json["Result"]))])
                    : List<T>.from(json["Result"].map((i) => (target).fromJson(i))))
                : [],
        data = target == null
            ? ((json["data"] is int || json["data"] is double) ? [json["data"]] : (json["data"] is Map ? List<T>.from([Map<String, dynamic>.from(json["data"])]) : json["data"]))
            : json.containsKey("data")
                ? ((json["data"] is Map) ? List<T>.from([target.fromJson(Map<String, dynamic>.from(json["data"]))]) : List<T>.from(json["data"].map((i) => (target).fromJson(i))))
                : [];
  //data = target == null ? null : List<T>.from(json["data"].map((i) => (target).fromJson(i)));

  bool get isNotSuccess => error != '';
}

abstract class BaseObject<T> {
  T fromJson(json);
}

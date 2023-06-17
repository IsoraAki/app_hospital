class BaseResponse<T> {
  bool status;
  int code;
  String message;

  BaseResponse({this.status = false, this.code = 0, this.message = ''});
}

import 'error_message.dart';

class Resource<T> {
  final bool? status;
  final String? msg;
  final int? code;
  final T? data;
  final ErrorResponse? error;
  final String? errorMsg;

  Resource({this.status = false, this.msg = '', this.code = 0, this.data, this.error, this.errorMsg = ''});

  factory Resource.success(T data) {
    return Resource(status: true, data: data);
  }

  factory Resource.fail(String error, {int? code}) {
    return Resource(status: false, errorMsg: error, code: code ?? 0);
  }

  //bool isSuccess() => status == true && data != null;
  bool isSuccess() => status == true;
}

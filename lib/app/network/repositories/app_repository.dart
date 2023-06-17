import 'package:my_app_hospital/app/network/data/api_docs.dart';
import 'package:my_app_hospital/app/network/data/provider/my_callback.dart';
import 'package:my_app_hospital/app/network/data/provider/my_reponse.dart';

class AppRepository {
  final callBack = MyCallBack();
  static final AppRepository _instance = AppRepository._internal();
  AppRepository._internal();

  String apiApp = ApiDocs.api;

  factory AppRepository() {
    return _instance;
  }

  Future<MyResponse?> login({String? username, String? password}) async {
    final params = {
      "username": username,
      "password": password,
    };

    //final queryParameters = {"agent": ApiDocs.agent};

    return await callBack.post(
      endPoint: apiApp + ApiDocs.login,
      //object: Login(),
      params: params,
      //queryParameters: queryParameters,
    );
  }
}

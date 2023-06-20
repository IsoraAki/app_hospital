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
      "ACCOUNTNAME": username,
      "PASSWORD": password,
    };

    //final queryParameters = {"agent": ApiDocs.agent};

    return await callBack.post(
      endPoint: apiApp + ApiDocs.login,
      //object: Login(),
      params: params,
      //queryParameters: queryParameters,
    );
  }

  Future<MyResponse?> passwordEncrypt({String? password}) async {
    final params = {
      "password": password,
    };
    return await callBack.get(
      url: '192.168.1.178:1019',
      endPoint: apiApp + ApiDocs.password,
      //object: Login(),
      params: params,
    );
  }
}

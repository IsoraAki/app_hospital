import 'package:my_app_hospital/app/network/data/api_docs.dart';
import 'package:my_app_hospital/app/network/data/model/office_model.dart';
import 'package:my_app_hospital/app/network/data/model/patient_information_model.dart';
import 'package:my_app_hospital/app/network/data/model/staff_infor_model.dart';
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
      endPoint: ApiDocs.login,
      //object: Login(),
      params: params,
      //queryParameters: queryParameters,
    );
  }

  Future<MyResponse?> profile({String? username, String? password}) async {
    return await callBack.get(
      endPoint: ApiDocs.profile,
      object: StaffInforModel(),
    );
  }

  Future<MyResponse?> department({String? username, String? password}) async {
    return await callBack.get(
      endPoint: ApiDocs.department,
      object: OfficeModer(),
    );
  }

  Future<MyResponse?> listPatient({String? maphongban, String? PCCS, int? isGhiChuBS, int? isSHBatThuong}) async {
    final params = {
      "maphongban": maphongban,
      "PCCS": PCCS,
      "isGhiChuBS": isGhiChuBS,
      "isSHBatThuong": isSHBatThuong,
    };

    return await callBack.get(
      endPoint: ApiDocs.listPatient,
      object: PatientInformationModel(),
      params: params,
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

import 'package:my_app_hospital/app/network/data/api_docs.dart';
import 'package:my_app_hospital/app/network/data/model/diagnostic_model.dart';
import 'package:my_app_hospital/app/network/data/model/infor_time_data_model.dart';
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
  //đăng nhập
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

  //thông tin tài khoản
  Future<MyResponse?> profile({String? username, String? password}) async {
    return await callBack.get(
      endPoint: ApiDocs.profile,
      object: StaffInforModel(),
    );
  }

  //danh sách phòng ban
  Future<MyResponse?> department({String? username, String? password}) async {
    return await callBack.get(
      endPoint: ApiDocs.department,
      object: OfficeModer(),
    );
  }

  // danh sách bệnh nhân
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

  //thông tin bệnh nhân chăm sóc
  Future<MyResponse?> infoPatient({String? chamsoc_id}) async {
    final params = {
      "chamsoc_id": chamsoc_id,
    };

    return await callBack.get(
      endPoint: ApiDocs.infoPatient,
      object: InforTimeDateModel(),
      params: params,
    );
  }

  //chuẩn đoán điều dưỡng
  Future<MyResponse?> cddd() async {
    return await callBack.get(
      endPoint: ApiDocs.cddd,
      object: DiagnosticModel(),
    );
  }

  //kiểm tra xem có được sửa y lệnh không
  Future<MyResponse?> checkEdit({String? chamsoc_id}) async {
    final params = {
      "chamsoc_id": chamsoc_id,
    };
    return await callBack.get(
      endPoint: ApiDocs.checkEdit,
      params: params,
    );
  }

  //xóa y lệnh
  Future<MyResponse?> deletaYL({String? chamsoc_id}) async {
    final params = {
      "chamsoc_id": chamsoc_id,
    };
    return await callBack.delete(
      endPoint: ApiDocs.deletaYL,
      params: params,
    );
  }

  // Future<MyResponse?> passwordEncrypt({String? password}) async {
  //   final params = {
  //     "password": password,
  //   };
  //   return await callBack.get(
  //     url: '192.168.1.178:1019',
  //     endPoint: apiApp + ApiDocs.password,
  //     //object: Login(),
  //     params: params,
  //   );
  // }
}

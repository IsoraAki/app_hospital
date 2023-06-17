

// import 'package:shop_app/shared/network/data/provider/my_callback.dart';

// class SettingRepository {
//   String END_POINT = "/setting";
//   final callBack = MyCallBack();
//   static final SettingRepository _instance = SettingRepository._internal();
//   SettingRepository._internal();

//   factory SettingRepository() {
//     return _instance;
//   }
//   Future<MyResponse?> getLanguage(String langCode) async {
//     final params = {'mod': 'get_label_language', 'lang_code': langCode};
//     return await callBack.get(endPoint: END_POINT, object: LabelModel(), params: params);
//   }

//   Future<MyResponse?> getListDomesticAirlinesVN(String langCode) async {
//     return await callBack.get(endPoint: ApiDocs.listDomestic);
//   }
// }

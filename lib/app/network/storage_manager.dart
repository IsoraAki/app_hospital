import 'package:shared_preferences/shared_preferences.dart';

import 'ids.dart';

class StorageManager {
  final String LABEL = "label";
  final String TOKEN = "token";
  static final StorageManager _instance = StorageManager._internal();

  StorageManager._internal();

  factory StorageManager() {
    return _instance;
  }

  // saveLabels(LoginModel model) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(LABEL, jsonEncode(model.user.first.toJson()));
  //   var list =<>();
  //   prefs.setStringList("key", [];
  // }
  // getLabels() async {
  //
  //   return LoginModel.fromJson(jsonDecode(stringValue));
  // }
  // saveToken(token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(Ids.storageToken, token);
  //   prefs.setBool(Ids.storageIsLogin, true);
  // }
  //
  // deleteDB() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  // }
  //
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(TOKEN) == null ? "" : prefs.getString(Ids.storageToken);
    return stringValue;
  }
  //
  // isLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(Ids.storageIsLogin) ?? false;
  // }
}

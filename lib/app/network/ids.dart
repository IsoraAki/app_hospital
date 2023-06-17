

class Ids {
  static const int  LIMIT   = 20;

 // shared prefereces
  static final String storageToken = "token";
  static final String storageProfile = "storage_profile";
  static final String storageCategory = "storage_category";
  static final String storageIsLogin = "storage_isLogin";

  static const int  daily = 0;//0-daily
  static const int  dataToDate = 1;//1-date to date

  static const int  finish   = 1;
  static const int  error = 0;
  static const int  pause   = 0;
  static const int  doing = 2;

  static const int send_type_one =0;// 0-gửi 1 lần
  static const int send_type_cycle =1;// 1-gửi theo chu kì ,

  static const String once ='once';// gửi 1 lần
  static const String hour ='hour';
  static const String date ='date';

  static const int  friend   = 0;
  static const int  customer = 1;
  static const int  group_chat   = 2;

  static const int PROCESS_ALL = 11;
  static const int PROCESS_TELEGRAM = 12;
  static const int PROCESS_ZALO = 13;

  static const String REVIEW_SELECT_ALL = "select_all";
  static const String REVIEW_SELECT_SINGLE= "select_single";

}

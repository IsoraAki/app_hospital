import 'package:my_app_hospital/app/network/data/provider/my_reponse.dart';

class StaffInforModel extends BaseObject<StaffInforModel> {
  String? manhanvien;
  String? tennhanvien;
  String? tenphongban;
  int? gioitinh;
  String? loginDep;
  String? maphongban;

  StaffInforModel({this.manhanvien, this.tennhanvien, this.tenphongban, this.gioitinh, this.loginDep, this.maphongban});

  StaffInforModel.fromJson(Map<String, dynamic> json) {
    manhanvien = json['manhanvien'];
    tennhanvien = json['tennhanvien'];
    tenphongban = json['tenphongban'];
    gioitinh = json['gioitinh'];
    loginDep = json['loginDep'];
    maphongban = json['maphongban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manhanvien'] = this.manhanvien;
    data['tennhanvien'] = this.tennhanvien;
    data['tenphongban'] = this.tenphongban;
    data['gioitinh'] = this.gioitinh;
    data['loginDep'] = this.loginDep;
    data['maphongban'] = this.maphongban;
    return data;
  }

  @override
  StaffInforModel fromJson(json) {
    return StaffInforModel.fromJson(json);
  }
}

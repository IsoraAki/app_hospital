class OfficeModer {
  String? tENPHONGBAN;
  String? rESOURCENAME;

  OfficeModer({this.tENPHONGBAN, this.rESOURCENAME});

  OfficeModer.fromJson(Map<String, dynamic> json) {
    tENPHONGBAN = json['TENPHONGBAN'];
    rESOURCENAME = json['RESOURCENAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TENPHONGBAN'] = this.tENPHONGBAN;
    data['RESOURCENAME'] = this.rESOURCENAME;
    return data;
  }
}

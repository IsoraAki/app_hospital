class DiagnosticModel {
  String? mA;
  String? tEN;
  String? nHOM;
  String? mUCTIEU;
  String? cANTHIEP;

  DiagnosticModel({this.mA, this.tEN, this.nHOM, this.mUCTIEU, this.cANTHIEP});

  DiagnosticModel.fromJson(Map<String, dynamic> json) {
    mA = json['MA'];
    tEN = json['TEN'];
    nHOM = json['NHOM'];
    mUCTIEU = json['MUCTIEU'];
    cANTHIEP = json['CANTHIEP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MA'] = this.mA;
    data['TEN'] = this.tEN;
    data['NHOM'] = this.nHOM;
    data['MUCTIEU'] = this.mUCTIEU;
    data['CANTHIEP'] = this.cANTHIEP;
    return data;
  }
}

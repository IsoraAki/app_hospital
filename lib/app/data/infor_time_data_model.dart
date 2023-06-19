class InforTimeDateModel {
  int? chamsocId;
  int? benhanId;
  int? luutruId;
  String? thoigianthuchien;
  String? dieuduong;
  String? mach;
  String? nhietdo;
  String? huyetap;
  String? cannang;
  String? nhiptho;
  String? mucdodau;
  String? chieucao;
  String? spo2;
  String? dienbien;
  String? ylenhchamsoc;
  String? chandoandieuduong;
  String? luonggia;
  String? ghichu;
  int? phancapchamsoc;
  String? chedodinhduong;
  String? muctieudieuduong;
  String? ghichubs;
  String? nguoithuchienCode;

  InforTimeDateModel(
      {this.chamsocId,
      this.benhanId,
      this.luutruId,
      this.thoigianthuchien,
      this.dieuduong,
      this.mach,
      this.nhietdo,
      this.huyetap,
      this.cannang,
      this.nhiptho,
      this.mucdodau,
      this.chieucao,
      this.spo2,
      this.dienbien,
      this.ylenhchamsoc,
      this.chandoandieuduong,
      this.luonggia,
      this.ghichu,
      this.phancapchamsoc,
      this.chedodinhduong,
      this.muctieudieuduong,
      this.ghichubs,
      this.nguoithuchienCode});

  InforTimeDateModel.fromJson(Map<String, dynamic> json) {
    chamsocId = json['chamsoc_id'];
    benhanId = json['benhan_id'];
    luutruId = json['luutru_id'];
    thoigianthuchien = json['thoigianthuchien'];
    dieuduong = json['dieuduong'];
    mach = json['mach'];
    nhietdo = json['nhietdo'];
    huyetap = json['huyetap'];
    cannang = json['cannang'];
    nhiptho = json['nhiptho'];
    mucdodau = json['mucdodau'];
    chieucao = json['chieucao'];
    spo2 = json['spo2'];
    dienbien = json['dienbien'];
    ylenhchamsoc = json['ylenhchamsoc'];
    chandoandieuduong = json['chandoandieuduong'];
    luonggia = json['luonggia'];
    ghichu = json['ghichu'];
    phancapchamsoc = json['phancapchamsoc'];
    chedodinhduong = json['chedodinhduong'];
    muctieudieuduong = json['muctieudieuduong'];
    ghichubs = json['ghichubs'];
    nguoithuchienCode = json['nguoithuchien_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chamsoc_id'] = this.chamsocId;
    data['benhan_id'] = this.benhanId;
    data['luutru_id'] = this.luutruId;
    data['thoigianthuchien'] = this.thoigianthuchien;
    data['dieuduong'] = this.dieuduong;
    data['mach'] = this.mach;
    data['nhietdo'] = this.nhietdo;
    data['huyetap'] = this.huyetap;
    data['cannang'] = this.cannang;
    data['nhiptho'] = this.nhiptho;
    data['mucdodau'] = this.mucdodau;
    data['chieucao'] = this.chieucao;
    data['spo2'] = this.spo2;
    data['dienbien'] = this.dienbien;
    data['ylenhchamsoc'] = this.ylenhchamsoc;
    data['chandoandieuduong'] = this.chandoandieuduong;
    data['luonggia'] = this.luonggia;
    data['ghichu'] = this.ghichu;
    data['phancapchamsoc'] = this.phancapchamsoc;
    data['chedodinhduong'] = this.chedodinhduong;
    data['muctieudieuduong'] = this.muctieudieuduong;
    data['ghichubs'] = this.ghichubs;
    data['nguoithuchien_code'] = this.nguoithuchienCode;
    return data;
  }
}

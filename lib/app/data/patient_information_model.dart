class PatientInformationModel {
  String? kHOALAMSANG;
  int? bENHANID;
  int? mAYTE;
  double? sOBENHAN;
  String? tENBENHNHAN;
  int? nAMSINH;
  String? dOITUONG;
  String? dIACHI;
  String? pHONGGIUONG;
  String? pCCS;
  String? cHANDOANICD;
  String? bSDIEUTRI;
  String? lOAIBA;
  int? sEX;
  String? fILENAME;
  int? isGhiChuBS;
  String? gHICHUBS;
  String? yLSHBat;

  PatientInformationModel(
      {this.kHOALAMSANG,
      this.bENHANID,
      this.mAYTE,
      this.sOBENHAN,
      this.tENBENHNHAN,
      this.nAMSINH,
      this.dOITUONG,
      this.dIACHI,
      this.pHONGGIUONG,
      this.pCCS,
      this.cHANDOANICD,
      this.bSDIEUTRI,
      this.lOAIBA,
      this.sEX,
      this.fILENAME,
      this.isGhiChuBS,
      this.gHICHUBS,
      this.yLSHBat});

  PatientInformationModel.fromJson(Map<String, dynamic> json) {
    kHOALAMSANG = json['KHOALAMSANG'] == null ? '' : json['KHOALAMSANG'].toString();
    bENHANID = json['BENHAN_ID'];
    mAYTE = json['MAYTE'];
    sOBENHAN = json['SOBENHAN'];
    tENBENHNHAN = json['TENBENHNHAN'];
    nAMSINH = json['NAMSINH'];
    dOITUONG = json['DOITUONG'] == null ? '' : json['DOITUONG'].toString();
    dIACHI = json['DIACHI'];
    pHONGGIUONG = json['PHONGGIUONG'] == null ? '' : json['PHONGGIUONG'].toString();
    pCCS = json['PCCS'] == null ? '' : json['PCCS'].toString();
    cHANDOANICD = json['CHANDOANICD'] == null ? '' : json['CHANDOANICD'].toString();
    bSDIEUTRI = json['BSDIEUTRI'];
    lOAIBA = json['LOAIBA'] == null ? '' : json['LOAIBA'].toString();
    sEX = json['SEX'];
    fILENAME = json['FILENAME'] == null ? '' : json['FILENAME'].toString();
    isGhiChuBS = json['isGhiChuBS'];
    gHICHUBS = json['GHICHUBS'];
    yLSHBat = json['YLSHBat'] == null ? '' : json['YLSHBat'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['KHOALAMSANG'] = this.kHOALAMSANG;
    data['BENHAN_ID'] = this.bENHANID;
    data['MAYTE'] = this.mAYTE;
    data['SOBENHAN'] = this.sOBENHAN;
    data['TENBENHNHAN'] = this.tENBENHNHAN;
    data['NAMSINH'] = this.nAMSINH;
    data['DOITUONG'] = this.dOITUONG;
    data['DIACHI'] = this.dIACHI;
    data['PHONGGIUONG'] = this.pHONGGIUONG;
    data['PCCS'] = this.pCCS;
    data['CHANDOANICD'] = this.cHANDOANICD;
    data['BSDIEUTRI'] = this.bSDIEUTRI;
    data['LOAIBA'] = this.lOAIBA;
    data['SEX'] = this.sEX;
    data['FILENAME'] = this.fILENAME;
    data['isGhiChuBS'] = this.isGhiChuBS;
    data['GHICHUBS'] = this.gHICHUBS;
    data['YLSHBat'] = this.yLSHBat;
    return data;
  }
}

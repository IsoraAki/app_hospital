class InforUserModer {
  int? uSERID;
  String? sUPERVISORUSERID;
  int? uSERGENDERID;
  int? eMPLOYEEID;
  String? eMPLOYEECODE;
  String? aCCOUNTNAME;
  String? cOMMONNAME;
  String? gIVENNAME;
  String? mIDDLENAME;
  String? fAMILYNAME;
  String? fULLNAME;
  String? uSERNOTE;
  int? dEPARTMENTID;
  String? lOCALE;
  int? aCTIVE;
  int? dELETED;
  String? sTARTDATE;
  String? eNDDATE;
  String? cREATEDBYUSERID;
  String? cREATEDDATE;
  int? mODIFIEDBYUSERID;
  String? mODIFIEDDATE;
  String? pASSWORD;
  int? pASSWORDCHANGE;
  String? pASSWORDMODIFIEDDATE;
  int? dEPARTMENTIDEXT;
  String? dEPARTMENTNAMEEXT;

  InforUserModer(
      {this.uSERID,
      this.sUPERVISORUSERID,
      this.uSERGENDERID,
      this.eMPLOYEEID,
      this.eMPLOYEECODE,
      this.aCCOUNTNAME,
      this.cOMMONNAME,
      this.gIVENNAME,
      this.mIDDLENAME,
      this.fAMILYNAME,
      this.fULLNAME,
      this.uSERNOTE,
      this.dEPARTMENTID,
      this.lOCALE,
      this.aCTIVE,
      this.dELETED,
      this.sTARTDATE,
      this.eNDDATE,
      this.cREATEDBYUSERID,
      this.cREATEDDATE,
      this.mODIFIEDBYUSERID,
      this.mODIFIEDDATE,
      this.pASSWORD,
      this.pASSWORDCHANGE,
      this.pASSWORDMODIFIEDDATE,
      this.dEPARTMENTIDEXT,
      this.dEPARTMENTNAMEEXT});

  InforUserModer.fromJson(Map<String, dynamic> json) {
    uSERID = json['USERID'];
    sUPERVISORUSERID = json['SUPERVISORUSERID'];
    uSERGENDERID = json['USERGENDERID'];
    eMPLOYEEID = json['EMPLOYEEID'];
    eMPLOYEECODE = json['EMPLOYEECODE'];
    aCCOUNTNAME = json['ACCOUNTNAME'];
    cOMMONNAME = json['COMMONNAME'];
    gIVENNAME = json['GIVENNAME'];
    mIDDLENAME = json['MIDDLENAME'];
    fAMILYNAME = json['FAMILYNAME'];
    fULLNAME = json['FULLNAME'];
    uSERNOTE = json['USERNOTE'];
    dEPARTMENTID = json['DEPARTMENTID'];
    lOCALE = json['LOCALE'];
    aCTIVE = json['ACTIVE'];
    dELETED = json['DELETED'];
    sTARTDATE = json['STARTDATE'];
    eNDDATE = json['ENDDATE'];
    cREATEDBYUSERID = json['CREATEDBYUSERID'];
    cREATEDDATE = json['CREATEDDATE'];
    mODIFIEDBYUSERID = json['MODIFIEDBYUSERID'];
    mODIFIEDDATE = json['MODIFIEDDATE'];
    pASSWORD = json['PASSWORD'];
    pASSWORDCHANGE = json['PASSWORDCHANGE'];
    pASSWORDMODIFIEDDATE = json['PASSWORDMODIFIEDDATE'];
    dEPARTMENTIDEXT = json['DEPARTMENTID_EXT'];
    dEPARTMENTNAMEEXT = json['DEPARTMENTNAME_EXT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USERID'] = this.uSERID;
    data['SUPERVISORUSERID'] = this.sUPERVISORUSERID;
    data['USERGENDERID'] = this.uSERGENDERID;
    data['EMPLOYEEID'] = this.eMPLOYEEID;
    data['EMPLOYEECODE'] = this.eMPLOYEECODE;
    data['ACCOUNTNAME'] = this.aCCOUNTNAME;
    data['COMMONNAME'] = this.cOMMONNAME;
    data['GIVENNAME'] = this.gIVENNAME;
    data['MIDDLENAME'] = this.mIDDLENAME;
    data['FAMILYNAME'] = this.fAMILYNAME;
    data['FULLNAME'] = this.fULLNAME;
    data['USERNOTE'] = this.uSERNOTE;
    data['DEPARTMENTID'] = this.dEPARTMENTID;
    data['LOCALE'] = this.lOCALE;
    data['ACTIVE'] = this.aCTIVE;
    data['DELETED'] = this.dELETED;
    data['STARTDATE'] = this.sTARTDATE;
    data['ENDDATE'] = this.eNDDATE;
    data['CREATEDBYUSERID'] = this.cREATEDBYUSERID;
    data['CREATEDDATE'] = this.cREATEDDATE;
    data['MODIFIEDBYUSERID'] = this.mODIFIEDBYUSERID;
    data['MODIFIEDDATE'] = this.mODIFIEDDATE;
    data['PASSWORD'] = this.pASSWORD;
    data['PASSWORDCHANGE'] = this.pASSWORDCHANGE;
    data['PASSWORDMODIFIEDDATE'] = this.pASSWORDMODIFIEDDATE;
    data['DEPARTMENTID_EXT'] = this.dEPARTMENTIDEXT;
    data['DEPARTMENTNAME_EXT'] = this.dEPARTMENTNAMEEXT;
    return data;
  }
}

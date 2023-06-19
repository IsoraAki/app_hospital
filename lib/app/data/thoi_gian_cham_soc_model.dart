class ThoiGianChamSocModel {
  int? chamsocId;
  String? thoigianchamsoc;

  ThoiGianChamSocModel({this.chamsocId, this.thoigianchamsoc});

  ThoiGianChamSocModel.fromJson(Map<String, dynamic> json) {
    chamsocId = json['chamsoc_id'];
    thoigianchamsoc = json['thoigianchamsoc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chamsoc_id'] = this.chamsocId;
    data['thoigianchamsoc'] = this.thoigianchamsoc;
    return data;
  }
}

class UserModel {
  String? username;
  int? id;
  int? iat;
  int? exp;
  String? image;

  UserModel({this.username, this.id, this.iat, this.exp, this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
    iat = json['iat'];
    exp = json['exp'];
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['id'] = this.id;
    data['iat'] = this.iat;
    data['exp'] = this.exp;
    data['image'] = this.image;
    return data;
  }
}

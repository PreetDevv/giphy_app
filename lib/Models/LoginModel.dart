class LoginModel {
  String? name;
  String? userID;
  String? email;

  LoginModel(
      {this.name,
        this.userID,
        this.email,

      });

  LoginModel.fromJson(dynamic json) {
    name = json['Name'].toString();
    userID = json['UserID'].toString();
    email = json['Email'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['UserID'] = this.userID;
    data['Email'] = this.email;
    return data;
  }
}

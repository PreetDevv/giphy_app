class FavModel {
  String? gifUrl;
  String? gifId;

  FavModel({this.gifUrl, this.gifId});

  FavModel.fromJson(Map<String, dynamic> json) {
    gifUrl = json['gifUrl'];
    gifId = json['gifId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gifUrl'] = this.gifUrl;
    data['gifId'] = this.gifId;
    return data;
  }
}

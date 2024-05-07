class PrivacyModel {
  String? sId;
  String? content;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PrivacyModel({this.sId, this.content, this.createdAt, this.updatedAt, this.iV});

  PrivacyModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
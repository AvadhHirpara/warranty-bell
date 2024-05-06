class SubCategoryModel {
  String? sId;
  String? categoryId;
  String? subCategoryName;
  String? categoryName;
  String? categoryImage;

  SubCategoryModel({this.sId, this.categoryId, this.subCategoryName, this.categoryName,this.categoryImage});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['category_id'];
    subCategoryName = json['sub_category_name'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['category_id'] = categoryId;
    data['sub_category_name'] = subCategoryName;
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    return data;
  }
}

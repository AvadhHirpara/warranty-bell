class CategoryModel {
  String? sId;
  String? categoryName;
  String? categoryImage;
  String? createdAt;
  String? updatedAt;
  int? productCount;

  CategoryModel(
      {this.sId,
        this.categoryName,
        this.categoryImage,
        this.createdAt,
        this.updatedAt,
        this.productCount});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productCount = json['product_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['product_count'] = productCount;
    return data;
  }
}

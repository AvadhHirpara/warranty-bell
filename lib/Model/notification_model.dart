class NotificationModel {
  String? sId;
  String? title;
  String? notificationMessage;
  String? userId;
  bool? isViewed;
  String? createdAt;
  String? productId;
  String? productName;
  String? purchaseDate;
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  String? photo;
  String? barcodeNumber;
  String? warrantyExpiryDate;
  String? remark;
  String? updatedAt;
  String? categoryImage;


  NotificationModel(
      {this.sId,
        this.title,
        this.notificationMessage,
        this.userId,
        this.isViewed,
        this.createdAt,
        this.productId,
        this.productName,
        this.purchaseDate,
        this.categoryId,
        this.categoryName,
        this.subCategoryId,
        this.subCategoryName,
        this.photo,
        this.barcodeNumber,
        this.warrantyExpiryDate,
        this.remark,
        this.updatedAt,
        this.categoryImage});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    notificationMessage = json['notification_message'];
    userId = json['user_id'];
    isViewed = json['is_viewed'];
    createdAt = json['createdAt'];
    productId = json['product_id'];
    productName = json['product_name'];
    purchaseDate = json['purchase_date'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subCategoryId = json['sub_category_id'];
    subCategoryName = json['sub_category_name'];
    photo = json['photo'];
    barcodeNumber = json['barcode_number'];
    warrantyExpiryDate = json['warranty_expiry_date'];
    remark = json['remark'];
    updatedAt = json['updatedAt'];
    categoryImage = json["category_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['notification_message'] = notificationMessage;
    data['user_id'] = userId;
    data['is_viewed'] = isViewed;
    data['createdAt'] = createdAt;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['purchase_date'] = purchaseDate;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['sub_category_id'] = subCategoryId;
    data['sub_category_name'] = subCategoryName;
    data['photo'] = photo;
    data['barcode_number'] = barcodeNumber;
    data['warranty_expiry_date'] = warrantyExpiryDate;
    data['remark'] = remark;
    data['updatedAt'] = updatedAt;
    data['category_image'] = categoryImage;

    return data;
  }
}

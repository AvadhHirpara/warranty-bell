// class ProductModel {
//   String? sId;
//   String? productName;
//   String? purchaseDate;
//   String? photo;
//   int? barcodeNumber;
//   String? warrantyExpiryDate;
//   String? remark;
//   String? categoryName;
//   String? subCategoryName;
//
//   ProductModel(
//       {this.sId,
//         this.productName,
//         this.purchaseDate,
//         this.photo,
//         this.barcodeNumber,
//         this.warrantyExpiryDate,
//         this.remark,
//         this.categoryName,
//         this.subCategoryName});
//
//   ProductModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     productName = json['product_name'];
//     purchaseDate = json['purchase_date'];
//     photo = json['photo'];
//     barcodeNumber = json['barcode_number'];
//     warrantyExpiryDate = json['warranty_expiry_date'];
//     remark = json['remark'];
//     categoryName = json['category_name'];
//     subCategoryName = json['sub_category_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['product_name'] = productName;
//     data['purchase_date'] = purchaseDate;
//     data['photo'] = photo;
//     data['barcode_number'] = barcodeNumber;
//     data['warranty_expiry_date'] = warrantyExpiryDate;
//     data['remark'] = remark;
//     data['category_name'] = categoryName;
//     data['sub_category_name'] = subCategoryName;
//     return data;
//   }
// }
// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  int? statuscode;
  String? message;
  List<Datum>? data;

  ProductModel({
    this.statuscode,
    this.message,
    this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    statuscode: json["statuscode"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? productName;
  DateTime? purchaseDate;
  String? categoryId;
  String? subCategoryId;
  String? photo;
  String? barcodeNumber;
  DateTime? warrantyExpiryDate;
  String? remark;
  String? categoryName;
  String? subCategoryName;
  String? categoryImage;

  Datum({
    this.id,
    this.productName,
    this.purchaseDate,
    this.categoryId,
    this.subCategoryId,
    this.photo,
    this.barcodeNumber,
    this.warrantyExpiryDate,
    this.remark,
    this.categoryName,
    this.subCategoryName,
    this.categoryImage
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    productName: json["product_name"],
    purchaseDate: json["purchase_date"] == null ? null : DateTime.parse(json["purchase_date"]),
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    photo: json["photo"],
    barcodeNumber: json["barcode_number"],
    warrantyExpiryDate: json["warranty_expiry_date"] == null ? null : DateTime.parse(json["warranty_expiry_date"]),
    remark: json["remark"],
    categoryName: json["category_name"],
    subCategoryName: json["sub_category_name"],
    categoryImage: json["category_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product_name": productName,
    "purchase_date": purchaseDate?.toIso8601String(),
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "photo": photo,
    "barcode_number": barcodeNumber.toString(),
    "warranty_expiry_date": warrantyExpiryDate?.toIso8601String(),
    "remark": remark,
    "category_name": categoryName,
    "sub_category_name": subCategoryName,
    "category_image": categoryImage,
  };
}
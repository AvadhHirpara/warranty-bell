part of 'add_product_bloc.dart';

class AddProductState {
  LoadStatus? status;
  List<CategoryModel>? categoryList = [];
  XFile? productImage;
  CategoryModel? categoryModel;
  SubCategoryModel? subCategoryModel;
  List<SubCategoryModel>? subCategoryList = [];
  String? purchaseDate;
  String? expiryDate;
  String? remarks;
  String? productName;
  String? flag;
  Datum? productModel;
  bool? isEdit;
  bool? isView;
  NotificationModel? notificationModel;
  bool? isNotification;

  AddProductState({
    this.status = LoadStatus.initial,
    this.categoryList,
    this.productImage,
    this.categoryModel,
    this.subCategoryList,
    this.subCategoryModel,
    this.productName,
    this.expiryDate,
    this.purchaseDate,
    this.remarks,
    this.flag,
    this.productModel,
    this.isEdit,
    this.isView = false,
    this.notificationModel,
    this.isNotification = false
  });

  AddProductState copyWith(
      {LoadStatus? status,
      List<CategoryModel>? categoryList,
      XFile? productImage,
      CategoryModel? categoryModel,
      List<SubCategoryModel>? subCategoryList,
      SubCategoryModel? subCategoryModel,
      String? purchaseDate,
      String? expiryDate,
      String? remarks,
      String? productName,
      String? flag,
      Datum? productModel,
      bool? isEdit,
      bool? isView,
      NotificationModel? notificationModel,
      bool? isNotification
      }) {
    return AddProductState(
      status: status ?? this.status,
      categoryList: categoryList ?? this.categoryList,
      productImage: productImage ?? this.productImage,
      categoryModel: categoryModel ?? this.categoryModel,
      subCategoryList: subCategoryList ?? this.subCategoryList,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      subCategoryModel: subCategoryModel ?? this.subCategoryModel,
      expiryDate: expiryDate ?? this.expiryDate,
      remarks: remarks ?? this.remarks,
      productName: productName ?? this.productName,
      flag: flag ?? this.flag,
      productModel: productModel ?? this.productModel,
      isEdit: isEdit ?? this.isEdit,
      isView: isView ?? this.isView,
      notificationModel: notificationModel ?? this.notificationModel,
      isNotification: isNotification ?? this.isNotification,
    );
  }

  @override
  List<Object?> get props => [status, categoryList, productImage, categoryModel, subCategoryList, purchaseDate, subCategoryModel, expiryDate, remarks, productName, flag,productModel, isEdit,isView,notificationModel,isNotification];
}

class AddProductInitial extends AddProductState {}

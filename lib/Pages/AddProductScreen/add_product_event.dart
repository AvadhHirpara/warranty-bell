part of 'add_product_bloc.dart';

class AddProductEvent {}

class AddProductInitialEvent extends AddProductEvent{
  Datum? productModel;
  bool? isEdit;
  bool? isView;
  bool? isNotification;
  NotificationModel? notificationModel;
  SubCategoryModel? subCategoryModel;
  AddProductInitialEvent({this.productModel,this.isEdit, this.subCategoryModel,this.isView, this.isNotification = false,this.notificationModel});
}

class SelectedImageEvent extends AddProductEvent{
  final XFile productImage;
  bool? isRemove;

  SelectedImageEvent(this.productImage, {this.isRemove = false});
}

class SelectedCategoryEvent extends AddProductEvent{
  CategoryModel? categoryModel;
  SubCategoryModel? subCategoryModel;
  SelectedCategoryEvent({this.categoryModel,this.subCategoryModel});
}

class SelectedSubCategoryEvent extends AddProductEvent{
  SubCategoryModel? subCategoryModel;
  SelectedSubCategoryEvent({this.subCategoryModel});
}

class DeleteProductEvent extends AddProductEvent{
  Datum? productModel;
  DeleteProductEvent({this.productModel});
}

class AddProductsEvent extends AddProductEvent{
  SubCategoryModel? subCategoryModel;
  bool? isEdit;
  AddProductsEvent({this.subCategoryModel,this.isEdit});
}

class EditableProduct extends AddProductEvent{
  bool? isView;
  EditableProduct({this.isView = false});
}

class ViewAllEvent extends AddProductEvent{
  SubCategoryModel? subCategoryModel;
  ViewAllEvent({this.subCategoryModel});
}
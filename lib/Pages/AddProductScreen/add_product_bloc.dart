import 'dart:async';
import 'package:WarrantyBell/Model/notification_model.dart';
import 'package:bloc/bloc.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Constants/app_date_formates.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/category_model.dart';
import 'package:WarrantyBell/Model/product_model.dart';
import 'package:WarrantyBell/Model/sub_category_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:WarrantyBell/main.dart';
import 'package:image_picker/image_picker.dart';
import '../../Constants/api_string.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  List<CategoryModel> categoryList = [];
  List<SubCategoryModel> subCategoryList = [];
  bool? isEditProduct = false;
  String? productId = '';

  AddProductBloc() : super(AddProductState()) {

    on<AddProductInitialEvent>((event, emit) {
      getCategory();
      isEditProduct = event.isEdit;
      (event.isNotification == true && event.isEdit == true) ? emit(state.copyWith(status: LoadStatus.initial, notificationModel: event.notificationModel,categoryList: categoryList,isEdit: event.isEdit,isNotification: event.isNotification, subCategoryModel: SubCategoryModel(categoryId: event.notificationModel!.categoryId,categoryName:event.notificationModel!.categoryName,subCategoryName:event.notificationModel!.subCategoryName,categoryImage: event.notificationModel!.categoryImage,sId: event.notificationModel!.subCategoryId),isView: event.isView))  :  event.isEdit == true ? emit(state.copyWith(status: LoadStatus.initial, productModel: event.productModel,categoryList: categoryList,isEdit: event.isEdit,isNotification: event.isNotification,subCategoryModel: SubCategoryModel(categoryId: event.productModel!.categoryId,categoryName:event.productModel!.categoryName,subCategoryName:event.productModel!.subCategoryName,categoryImage: event.productModel!.categoryImage,sId: event.productModel!.subCategoryId),isView: event.isView)) :
      emit(state.copyWith(status: LoadStatus.initial, categoryList: categoryList,isEdit: event.isEdit,isView: event.isView,isNotification: event.isNotification));
      if(event.isEdit == true && event.isNotification != true){
        productId = event.productModel?.id;
        productName.text = event.productModel!.productName.toString();
        productPurchaseDate.text =  outputFormat.format(event.productModel!.purchaseDate!);
        productExpiryDate.text = outputFormat.format(event.productModel!.warrantyExpiryDate!);
        productDescription.text =  event.productModel!.remark.toString();
        productBarcodeNumber.text = event.productModel!.barcodeNumber.toString();
        event.subCategoryModel = SubCategoryModel(categoryId: event.productModel!.categoryId,categoryName:event.productModel!.categoryName,subCategoryName:event.productModel!.subCategoryName,categoryImage: event.productModel!.categoryImage,sId: event.productModel!.subCategoryId);
      } else if(event.isEdit == true && event.isNotification == true){
        print("category image is ${event.notificationModel!.categoryImage}");
        productId = event.notificationModel?.productId;
        productName.text = event.notificationModel!.productName.toString();
        productPurchaseDate.text =  outputFormat.format(DateTime.parse(event.notificationModel!.purchaseDate!));
        productExpiryDate.text = outputFormat.format(DateTime.parse(event.notificationModel!.warrantyExpiryDate!));
        productDescription.text =  event.notificationModel!.remark.toString();
        productBarcodeNumber.text = event.notificationModel!.barcodeNumber.toString();
        event.subCategoryModel = SubCategoryModel(categoryId: event.notificationModel!.categoryId,categoryName:event.notificationModel!.categoryName,subCategoryName:event.notificationModel!.subCategoryName,categoryImage: event.notificationModel!.categoryImage,sId: event.notificationModel!.subCategoryId);
      }else{
        event.isView = true;
        productName.clear();
        productPurchaseDate.text = outputFormat.format(DateTime.now());
        productExpiryDate.text = outputFormat.format(DateTime.now().add(const Duration(days: 365))) ;
        productDescription.clear();
        productBarcodeNumber.clear();
      }
    });

    on<SelectedImageEvent>(_onSelectedImageEvent);
    on<SelectedCategoryEvent>(_onSelectedCategory);
    on<SelectedSubCategoryEvent>(_onSelectedSubCategory);
    on<AddProductsEvent>(_addProductsOnTap);
    on<DeleteProductEvent>(deleteProductOnTap);
    on<EditableProduct>(onEditProduct);

  }

  FutureOr<void> onEditProduct(EditableProduct event, Emitter<AddProductState> emit) {
    emit(state.copyWith(status : LoadStatus.initial,isView: event.isView));
  }

  FutureOr<void> _onSelectedImageEvent(SelectedImageEvent event, Emitter<AddProductState> emit) {
    print("selected crop image is ${event.productImage}");
    emit(state.copyWith(status : LoadStatus.initial,productImage: event.productImage));
  }

  FutureOr<void> _onSelectedCategory(SelectedCategoryEvent event, Emitter<AddProductState> emit) {
    getSubCategory(event.categoryModel!.sId!);
  }

  FutureOr<void> _onSelectedSubCategory(SelectedSubCategoryEvent event, Emitter<AddProductState> emit) {
    emit(state.copyWith(status: LoadStatus.initial,subCategoryModel: event.subCategoryModel));
  }

  FutureOr<void> _addProductsOnTap(AddProductsEvent event, Emitter<AddProductState> emit) {
    // emit(state.copyWith(subCategoryModel: event.subCategoryModel));
    Map<String, dynamic> body;
     if(isEditProduct == false){
       body = {
         "product_name" : productName.text,
         "purchase_date" : productPurchaseDate.text,
         "category_id" : event.subCategoryModel?.categoryId,
         "sub_category_id" : event.subCategoryModel?.sId,
         "barcode_number" : productBarcodeNumber.text,
         "warranty_expiry_date" : productExpiryDate.text,
         "remark" : productDescription.text
       };
     } else {
       if(state.productImage == null){
         body = {
           "product_name" : productName.text,
           "purchase_date" : productPurchaseDate.text,
           "category_id" : event.subCategoryModel?.categoryId,
           "sub_category_id" : event.subCategoryModel?.sId,
           "barcode_number" : productBarcodeNumber.text,
           "warranty_expiry_date" : productExpiryDate.text,
           "remark" : productDescription.text,
           "product_id" : productId,
           "photo" : ""
         };
       }else{
         body = {
           "product_name" : productName.text,
           "purchase_date" : productPurchaseDate.text,
           "category_id" : event.subCategoryModel?.categoryId,
           "sub_category_id" : event.subCategoryModel?.sId,
           "barcode_number" : productBarcodeNumber.text,
           "warranty_expiry_date" : productExpiryDate.text,
           "remark" : productDescription.text,
           "product_id" : productId
         };
       }
     }
    addProducts(body);

  }

  ///DeleteProductButtonTap
  FutureOr<void> deleteProductOnTap(DeleteProductEvent event, Emitter<AddProductState>emit){
    deleteProduct(event.productModel?.id,);
  }

  ///GetCategory
  Future addProducts(Map<String, dynamic> body) async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res;
      if(isEditProduct == false){
        res = await ApiService.request(ApiUrls.addProducts, RequestMethods.POSTFILE, showLogs: true,header: tokeWithHeader,requestBody: body,postFiles: state.productImage);
      }else{
        res = await ApiService.request(ApiUrls.updateProduct, RequestMethods.POSTFILE, showLogs: true,header: tokeWithHeader,requestBody: body,postFiles: state.productImage);
      }
      if(res != null){
        if(res[UserModelKeys.data] != null) {
          print("update product");
          emit(state.copyWith(status:LoadStatus.success,flag: "product"));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      print("add products exception $e");
      emit(state.copyWith(status:LoadStatus.failure));
    }
  }

  ///GetCategory
  Future getCategory() async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    try{
      var res = await ApiService.request(ApiUrls.category, RequestMethods.GET, showLogs: true,header: tokeWithHeader);
      if(res != null){
        if(res[UserModelKeys.data] != null && res[UserModelKeys.data] is List) {
          for (var element in (res[UserModelKeys.data])) {
            CategoryModel categoryModel = CategoryModel.fromJson(element ?? {});
            categoryList.add(categoryModel);
            print("category length is ${categoryList.length}");
          }
          emit(state.copyWith(status:LoadStatus.success));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("category exception $e");
    }
  }

  ///GetSubCategory
  Future getSubCategory(String categoryId) async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    subCategoryList.clear();
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request("${ApiUrls.subCategory}?${ApiUrls.categoryId}=$categoryId", RequestMethods.GET, showLogs: true,header: tokeWithHeader);
      if(res != null){
        if(res[UserModelKeys.data] != null && res[UserModelKeys.data] is List) {
          for (var element in (res[UserModelKeys.data])) {
            SubCategoryModel subCategoryModel = SubCategoryModel.fromJson(element ?? {});
            subCategoryList.add(subCategoryModel);
            print("category length is ${subCategoryList.length}");
          }

          emit(state.copyWith(status:LoadStatus.success,flag: "subCategory",subCategoryList: subCategoryList));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("category exception $e");
    }
  }

  ///DeleteProduct
  Future deleteProduct(String? id) async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request("${ApiUrls.deleteProduct}?${ApiUrls.id}=$id", RequestMethods.POST, showLogs: true, header: tokeWithHeader);
      if(res != null){
        if(res["statuscode"] == 201) {
          emit(state.copyWith(status:LoadStatus.success,flag: "delete"));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("delete product exception $e");
    }
  }

}
import 'package:bloc/bloc.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/category_model.dart';
import 'package:WarrantyBell/Model/product_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'dart:async';
import 'package:WarrantyBell/main.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(HomeState()) {

     on<HomeInitialEvent>((event, emit){
      getProducts();
      getCategory();
    });

     on<DeleteProductEvent>((event, emit) => deleteProductOnTap(event, emit));
     on<LogoutEvent>((event, emit) => logout(event, emit));
     on<ChangeTabEvent>((event, emit) => isChangeTab(event, emit));
  }

  ///DeleteProductButtonTap
  FutureOr<void> deleteProductOnTap(DeleteProductEvent event, Emitter<HomeState>emit){
    deleteProduct(event.productModel?.id,);
  }

  ///DeleteProductButtonTap
  FutureOr<void> logout ( LogoutEvent event, Emitter<HomeState>emit){
    logOut();
  }

  FutureOr<void> isChangeTab (ChangeTabEvent event, Emitter<HomeState>emit){
    emit(state.copyWith(status: LoadStatus.initial,isSelectProduct: event.isSelectProduct,isSelectCategories: event.isSelectCategories));
  }

  ///GetProducts
  Future getProducts() async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
  emit(state.copyWith(status:LoadStatus.loading));
  try{
    var res = await ApiService.request(ApiUrls.products, RequestMethods.GET, showLogs: true,header: tokeWithHeader);
    if(res != null){
        if(res[UserModelKeys.data] != null) {
          List<Datum> productList = (res["data"] as List).map((data) => Datum.fromJson(data)).toList();
          emit(state.copyWith(status:LoadStatus.success,flag: "product",productsList: productList));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
    }
  }
  catch(e){
    emit(state.copyWith(status:LoadStatus.failure));
    print("get home products exception $e");
  }
}

  ///Logout
  Future logOut() async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
  emit(state.copyWith(status:LoadStatus.loading));
  try{
    var res = await ApiService.request(ApiUrls.logout, RequestMethods.POST, showLogs: true, header: tokeWithHeader);
    if(res != null){
      if(res["statuscode"] == 201) {
        emit(state.copyWith(status:LoadStatus.success,flag: "logout"));
        email.clear();
        loginPassword.clear();
      }else{
        emit(state.copyWith(status:LoadStatus.failure));
      }
    }
  }
  catch(e){
    emit(state.copyWith(status:LoadStatus.failure));
    print("logout exception $e");
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

  ///GetCategory
  Future getCategory() async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    List<CategoryModel> categoryList = [];

    try{
      var res = await ApiService.request(ApiUrls.category, RequestMethods.GET, showLogs: true,header: tokeWithHeader);
      if(res != null){
        if(res[UserModelKeys.data] != null && res[UserModelKeys.data] is List) {
          for (var element in (res[UserModelKeys.data])) {
            CategoryModel categoryModel = CategoryModel.fromJson(element ?? {});
            categoryList.add(categoryModel);
            emit(state.copyWith(status:LoadStatus.success,flag: "category",categoryList:categoryList));
          }
          emit(state.copyWith(status:LoadStatus.success));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("get home category exception $e");
    }
  }

}

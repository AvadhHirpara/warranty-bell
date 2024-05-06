import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/category_model.dart';
import 'package:WarrantyBell/Model/sub_category_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:WarrantyBell/main.dart';

part 'all_category_event.dart';
part 'all_category_state.dart';

class AllCategoryBloc extends Bloc<AllCategoryEvent, AllCategoryState> {
  List<SubCategoryModel> subCategoryList = [];

  AllCategoryBloc() : super(AllCategoryState()) {
    on<SelectedCategoryEvent>(_onSelectedCategory);
    on<SelectedSubCategoryEvent>(_onSelectedSubCategory);
  }

  FutureOr<void> _onSelectedCategory(SelectedCategoryEvent event, Emitter<AllCategoryState> emit) {
    getSubCategory(event.categoryModel!.sId!);
    emit(state.copyWith(subCategoryList: subCategoryList));
  }

  FutureOr<void> _onSelectedSubCategory(SelectedSubCategoryEvent event, Emitter<AllCategoryState> emit) {
    emit(state.copyWith(subCategoryModel: event.subCategoryModel));
    print("sub category model is ${event.subCategoryModel}");
  }


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
      var res = await ApiService.request("${ApiUrls.subCategory}?${ApiUrls.categoryId}=$categoryId", RequestMethods.GET, showLogs: true, header: tokeWithHeader);
      if(res != null){
        if(res[UserModelKeys.data] != null && res[UserModelKeys.data] is List) {
          for (var element in (res[UserModelKeys.data])) {
            SubCategoryModel subCategoryModel = SubCategoryModel.fromJson(element ?? {});
            subCategoryList.add(subCategoryModel);
            print("category length is ${subCategoryList.length}");
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

}
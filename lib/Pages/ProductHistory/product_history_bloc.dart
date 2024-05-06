import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/product_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:WarrantyBell/main.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_history_event.dart';
part 'product_history_state.dart';

class ProductHistoryBloc extends Bloc<ProductHistoryEvent, ProductHistoryState> {
  Map<String,String> commonHeaderWithTokens = {};

  ProductHistoryBloc() : super(ProductHistoryState()) {

    on<ProductHistoryInitialEvent>((event, emit){
      getProductsHistory();
    });

  }

  ///GetProductsHistory
  Future getProductsHistory() async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request(ApiUrls.productHistory, RequestMethods.GET, showLogs: true,header: tokeWithHeader);
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

}
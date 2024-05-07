import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/privacy_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'terms_condition_event.dart';
part 'terms_condition_state.dart';

class TermsConditionBloc extends Bloc<TermsConditionEvent, TermsConditionState> {
  String content = '';
  TermsConditionBloc() : super(TermsConditionState()) {
    on<TermsInitialEvent>((event, emit){
      getTermsCondition();
    });
  }

  ///GetProducts
  Future getTermsCondition() async {
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request(ApiUrls.terms, RequestMethods.GET, showLogs: true,header:commonHeader);
      if(res != null){
        if(res[UserModelKeys.data] != null) {
          PrivacyModel userRes = PrivacyModel.fromJson(res[UserModelKeys.data]);
          content = userRes.content.toString();
          print("content data is $content");
          emit(state.copyWith(status:LoadStatus.success,termsData: content));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("terms condition exception $e");
    }
  }
}

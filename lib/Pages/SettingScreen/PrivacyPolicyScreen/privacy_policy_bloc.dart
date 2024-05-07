import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/privacy_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'privacy_policy_event.dart';
part 'privacy_policy_state.dart';

class PrivacyPolicyBloc extends Bloc<PrivacyPolicyEvent, PrivacyPolicyState> {
  String content = '';
  PrivacyPolicyBloc() : super(PrivacyPolicyState()) {
    on<PrivacyInitialEvent>((event, emit){
      getPrivacyPolicy();
    });
  }

  ///GetProducts
  Future getPrivacyPolicy() async {
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request(ApiUrls.privacy, RequestMethods.GET, showLogs: true,header:commonHeader);
      if(res != null){
        if(res[UserModelKeys.data] != null) {
          PrivacyModel userRes = PrivacyModel.fromJson(res[UserModelKeys.data]);
            content = userRes.content!;
          emit(state.copyWith(status:LoadStatus.success,privacyData: content));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("privacy policy exception $e");
    }
  }

}

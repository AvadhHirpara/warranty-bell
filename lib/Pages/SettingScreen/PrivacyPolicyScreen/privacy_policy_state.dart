part of 'privacy_policy_bloc.dart';

class PrivacyPolicyState {
  LoadStatus? status;
  String? privacyData;

  PrivacyPolicyState({this.status = LoadStatus.initial,this.privacyData = ''});

  PrivacyPolicyState copyWith({
    LoadStatus? status,
    String? privacyData

  }) {
    return PrivacyPolicyState(
      status: status ?? this.status,
      privacyData: privacyData ?? this.privacyData,
    );
  }

  @override
  List<Object?> get props => [
    status,
    privacyData
  ];

}

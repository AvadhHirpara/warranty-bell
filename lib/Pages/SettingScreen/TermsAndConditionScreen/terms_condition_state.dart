part of 'terms_condition_bloc.dart';

class TermsConditionState {
  LoadStatus? status;
  String? termsData;

  TermsConditionState({this.status = LoadStatus.initial,this.termsData = ''});

  TermsConditionState copyWith({
    LoadStatus? status,
    String? termsData

  }) {
    return TermsConditionState(
      status: status ?? this.status,
      termsData: termsData ?? this.termsData,
    );
  }

  @override
  List<Object?> get props => [
    status,
    termsData
  ];

}

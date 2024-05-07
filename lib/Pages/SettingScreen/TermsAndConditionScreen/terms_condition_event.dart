part of 'terms_condition_bloc.dart';

class TermsConditionEvent {}

class TermsInitialEvent extends TermsConditionEvent{
  String? termsData;
  TermsInitialEvent({this.termsData});
}

part of 'privacy_policy_bloc.dart';

class PrivacyPolicyEvent {}

class PrivacyInitialEvent extends PrivacyPolicyEvent{
  String? privacyData;
  PrivacyInitialEvent({this.privacyData});
}

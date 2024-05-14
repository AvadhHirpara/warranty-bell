part of 'home_bloc.dart';

class HomeEvent {}

class HomeInitialEvent extends HomeEvent{
  String? searchText;
  HomeInitialEvent({this.searchText});
}

class DeleteProductEvent extends HomeEvent{
  Datum? productModel;
  DeleteProductEvent({this.productModel});
}

class LogoutEvent extends HomeEvent{}


class ChangeTabEvent extends HomeEvent{
  bool? isSelectCategories;
  bool? isSelectProduct;

   ChangeTabEvent({this.isSelectProduct = true, this.isSelectCategories = false});
}
class SearchProductEvent extends HomeEvent{
  String? searchText;
  List<Datum>? searchProduct = [];

  SearchProductEvent({this.searchText,this.searchProduct});
}
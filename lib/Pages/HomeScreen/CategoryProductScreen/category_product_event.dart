part of 'category_product_bloc.dart';

class CategoryProductEvent {}

class CategoryProductInitialEvent extends CategoryProductEvent{
  String? categoryId;
  CategoryProductInitialEvent({this.categoryId});
}

part of 'home_bloc.dart';

class HomeState {
 LoadStatus? status;
 List<Datum>? productsList = [];
 String? flag;
 List<CategoryModel>? categoryList = [];
 HomeState({this.status = LoadStatus.initial,this.productsList,this.flag, this.categoryList});

 HomeState copyWith({
  LoadStatus? status,
  List<Datum>? productsList,
  List<Datum>? searchProduct,
  String? flag,
  String? searchProductText,
  List<CategoryModel>? categoryList
 }) {
  return HomeState(
   status: status ?? this.status,
   productsList: productsList ?? this.productsList,
   flag: flag ?? this.flag,
   categoryList: categoryList ?? this.categoryList,
  );
 }

 @override
 List<Object?> get props => [
  status,
  productsList,
  flag,
  categoryList
 ];

}
part of 'home_bloc.dart';

class HomeState {
 LoadStatus? status;
 List<Datum>? productsList = [];
 String? flag;
 List<CategoryModel>? categoryList = [];
 bool isSelectCategories;
 bool isSelectProduct;
 String? message;
 HomeState({this.status = LoadStatus.initial,this.productsList,this.flag, this.categoryList,this.isSelectProduct = true,this.isSelectCategories = false,this.message = ''});

 HomeState copyWith({
  LoadStatus? status,
  List<Datum>? productsList,
  List<Datum>? searchProduct,
  String? flag,
  String? searchProductText,
  List<CategoryModel>? categoryList,
  bool? isSelectCategories,
  bool? isSelectProduct,
  String? message
 }) {
  return HomeState(
   status: status ?? this.status,
   productsList: productsList ?? this.productsList,
   flag: flag ?? this.flag,
   categoryList: categoryList ?? this.categoryList,
   isSelectCategories: isSelectCategories ?? this.isSelectCategories,
   isSelectProduct: isSelectProduct ?? this.isSelectProduct,
   message: message ?? this.message,
  );
 }

 @override
 List<Object?> get props => [
  status,
  productsList,
  flag,
  categoryList,
  isSelectProduct,
  isSelectCategories,
  message
 ];

}
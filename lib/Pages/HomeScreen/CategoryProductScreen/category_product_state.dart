part of 'category_product_bloc.dart';

class CategoryProductState {
  LoadStatus? status;
  List<Datum>? productsList = [];
  String? flag;
  String? categoryId;
  CategoryProductState({this.status = LoadStatus.initial,this.productsList,this.flag,this.categoryId});

  CategoryProductState copyWith({
    LoadStatus? status,
    List<Datum>? productsList,
    String? flag,
    String? categoryId
  }) {
    return CategoryProductState(
      status: status ?? this.status,
      productsList: productsList ?? this.productsList,
      flag: flag ?? this.flag,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [
    status,
    productsList,
    flag,
    categoryId
  ];

}
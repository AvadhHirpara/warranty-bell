part of 'product_history_bloc.dart';

class ProductHistoryState {
  LoadStatus? status;
  List<Datum>? productsList = [];
  String? flag;
  ProductHistoryState({this.status = LoadStatus.initial,this.productsList,this.flag});

  ProductHistoryState copyWith({
    LoadStatus? status,
    List<Datum>? productsList,
    String? flag,
  }) {
    return ProductHistoryState(
      status: status ?? this.status,
      productsList: productsList ?? this.productsList,
      flag: flag ?? this.flag,
    );
  }

  @override
  List<Object?> get props => [
    status,
    productsList,
    flag,
  ];

}

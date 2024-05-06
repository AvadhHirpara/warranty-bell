part of 'all_category_bloc.dart';

class AllCategoryState {
  LoadStatus? status;
  List<CategoryModel>? categoryList = [];
  CategoryModel? categoryModel;
  SubCategoryModel? subCategoryModel;
  List<SubCategoryModel>? subCategoryList = [];

  AllCategoryState({this.status = LoadStatus.initial, this.categoryList,this.categoryModel,this.subCategoryList,this.subCategoryModel });

  AllCategoryState copyWith({
    LoadStatus? status,
    List<CategoryModel>? categoryList,
    CategoryModel? categoryModel,
    SubCategoryModel? subCategoryModel,
    List<SubCategoryModel>? subCategoryList
  }) {
    return AllCategoryState(
      status: status ?? this.status,
      categoryList: categoryList ?? this.categoryList,
      categoryModel: categoryModel ?? this.categoryModel,
      subCategoryList: subCategoryList ?? this.subCategoryList,
      subCategoryModel: subCategoryModel ?? this.subCategoryModel,

    );
  }
}
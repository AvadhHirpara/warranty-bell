part of 'all_category_bloc.dart';

class AllCategoryEvent {}


class AllCategoryInitialEvent extends AllCategoryEvent{}


class SelectedCategoryEvent extends AllCategoryEvent{
  CategoryModel? categoryModel;
  SelectedCategoryEvent({this.categoryModel});
}

class SelectedSubCategoryEvent extends AllCategoryEvent{
  SubCategoryModel? subCategoryModel;
  SelectedSubCategoryEvent({this.subCategoryModel});
}
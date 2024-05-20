import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/category_model.dart';
import 'package:WarrantyBell/Model/sub_category_model.dart';
import 'package:WarrantyBell/Pages/AddProductScreen/Module/category_view.dart';
import 'package:WarrantyBell/Pages/AllCategoryScreen/all_category_bloc.dart';
import 'package:WarrantyBell/utils/Mixins/app_exit_dialog.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  List<CategoryModel> categoryList = [];

  @override
  void didChangeDependencies() {
    categoryList = ModalRoute.of(context)!.settings.arguments as List<CategoryModel>;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocConsumer<AllCategoryBloc, AllCategoryState>(
        listener: (context, state) {
          if(state.status == LoadStatus.success){
            showSubCategory(context,state.subCategoryList!);
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () => showExitPopup(context),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                appBar: PreferredSize(
                    preferredSize: const Size(100, 150),
                    child: Container(
                      padding: const EdgeInsets.only(top: 65),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(end: Alignment.centerRight, colors: <Color>[AppBarColor.lightBlue, AppBarColor.blue]),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Stack(
                          children: [
                            Positioned(
                                left: 0,
                                right: 0,
                                child: commonTextView(CategoryString.category, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18)),
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back, color: AppIconColor.white)),
                          ],
                        ),
                      ),
                    )),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SingleChildScrollView(
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5),
                          itemCount: categoryList.length,
                          itemBuilder: (contexts, index) {
                            return GestureDetector(
                                onTap: () {
                                  context.read<AllCategoryBloc>().add(SelectedCategoryEvent(categoryModel: categoryList[index]));
                                },
                                child: commonCategoryCardView(categoryList[index].categoryName, categoryList[index].categoryImage));
                          })),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  showSubCategory(BuildContext context, List<SubCategoryModel>? subcategory) {
    return showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          backgroundColor: AppBackGroundColor.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: subcategory?.isNotEmpty ?? false  ? ListView.separated(
              shrinkWrap: true,
              itemCount: subcategory?.length ?? 0,
              itemBuilder: (contexts, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                      Navigator.pop(context, subcategory![index]);
                      context.read<AllCategoryBloc>().add(SelectedSubCategoryEvent(subCategoryModel: subcategory[index]));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: commonTextView(subcategory?[index].subCategoryName ?? '',fontWeight: FontWeight.w500,color: AppTextColor.lightBlack,fontSize: 18)),
                );
              }, separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },) : const Text(CategoryString.noSubCategory),
          ),
        );
      },
    );
  }
}

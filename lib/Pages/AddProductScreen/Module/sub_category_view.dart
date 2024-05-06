import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Model/sub_category_model.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';

///ShowSubCategory
showSubCategory (BuildContext context,List<SubCategoryModel> subcategory){
  return showDialog(
    context: context,
    builder: (BuildContext context1) {
      return AlertDialog(
        backgroundColor: AppBackGroundColor.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: subcategory.length,
            itemBuilder: (contexts, index){
              return GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pop(context,subcategory[index]);
                },
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: commonTextView(subcategory[index].subCategoryName!,fontWeight: FontWeight.w500,color: AppTextColor.lightBlack,fontSize: 18)),
              );
            }, separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },),
        ),
      );
    },
  );
}
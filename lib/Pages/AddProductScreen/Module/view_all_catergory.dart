import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Element/responsive_size_value.dart';
import 'package:WarrantyBell/Model/category_model.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///ShowAllCategory
 showAllCategory (BuildContext context,List<CategoryModel>item){
  return showDialog(
    context: context,
    builder: (BuildContext context1) {
      return AlertDialog(
        backgroundColor: AppBackGroundColor.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: double.maxFinite,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: item.length,
              itemBuilder: (contexts, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    // context.read<HomeBloc>().add(SelectedCategoryEvent(categoryModel: item[index]));
                    // showSubCategory(context);
                    },
                  child: SizedBox(
                    width: setWidth(160),
                    child: Card(
                      shadowColor: AppBackGroundColor.darkGrey.withOpacity(0.5),
                      child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: AppBackGroundColor.blue,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SvgPicture.asset(item[index].categoryImage!),
                              ),
                            ),
                            const SizedBox(width: 10),
                            commonTextView(item[index].categoryName!,fontWeight: FontWeight.w500,color: AppTextColor.blue,fontSize: 18)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
    },
  );
}
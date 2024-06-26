import 'package:cached_network_image/cached_network_image.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Constants/app_date_formates.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/HomeScreen/CategoryProductScreen/category_product_bloc.dart';
import 'package:WarrantyBell/Pages/HomeScreen/Module/common_rich_text.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:WarrantyBell/utils/Mixins/app_exit_dialog.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocConsumer<CategoryProductBloc, CategoryProductState>(
        listener: (context, state) {
          if (state.status == LoadStatus.loading) {
            showProgressThreeDots(context, loaderColor: AppBackGroundColor.blue);
          } else if (state.status == LoadStatus.success && state.flag == "product") {
            hideProgress(context);
          } else if (state.status == LoadStatus.failure) {
            hideProgress(context);
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
                      padding: const EdgeInsets.only(top: 75),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(end: Alignment.centerRight, colors: <Color>[AppBarColor.lightBlue, AppBarColor.blue]),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back, color: AppIconColor.white)),
                            Expanded(child: commonTextView(CommonString.products, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18)),
                          ],
                        ),
                      ),
                    )),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.productsList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, addProductScreen, arguments: {"productModel": state.productsList?[index], "isEdit": true,"isView" : false,"isNotification" : false});
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppBackGroundColor.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 1),
                                      blurRadius: 5,
                                      spreadRadius: 4,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(90),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),topLeft:Radius.circular(10)),
                                            child: CachedNetworkImage(
                                              imageUrl: "${ApiUrls.imageUrl}${state.productsList?[index].photo}",
                                              height: 120,
                                              width: 100,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) => Image.asset('', height: 100, width: 90, fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              commonRichText(HomeString.productName, state.productsList?[index].productName),
                                              paddingTop(02),
                                              commonRichText(
                                                HomeString.category,
                                                "${state.productsList?[index].categoryName}(${state.productsList?[index].subCategoryName})",
                                              ),
                                              paddingTop(02),
                                              commonRichText(HomeString.currentDate, outputFormat.format(state.productsList![index].purchaseDate!),maxLine: 2),
                                              paddingTop(02),
                                              commonRichText(HomeString.warrantyDate, outputFormat.format(state.productsList![index].warrantyExpiryDate!),maxLine: 2),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

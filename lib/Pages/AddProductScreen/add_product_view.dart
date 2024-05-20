import 'dart:io';
import 'dart:ui';
import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Constants/app_date_formates.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Controller/custom_text_field.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Element/responsive_size_value.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/sub_category_model.dart';
import 'package:WarrantyBell/Pages/AddProductScreen/Module/calender_view.dart';
import 'package:WarrantyBell/Pages/AddProductScreen/Module/category_view.dart';
import 'package:WarrantyBell/Pages/AddProductScreen/Module/image_view.dart';
import 'package:WarrantyBell/Pages/AddProductScreen/add_product_bloc.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:WarrantyBell/Utils/Mixins/alert_dialog.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:WarrantyBell/Utils/validation.dart';
import 'package:WarrantyBell/widgets/common_button.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:permission_handler/permission_handler.dart';

bool isImageCapture = false;

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<FocusNode> focusNode = [FocusNode(), FocusNode(), FocusNode(), FocusNode()];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode validate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    double width;
    double height;

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state.status == LoadStatus.loading) {
            showProgressThreeDots(context, loaderColor: AppBackGroundColor.blue);
          }
          if (state.status == LoadStatus.success && state.flag == "product") {
            hideProgress(context);
            Navigator.pushNamed(context, homeScreen);
          }
          if (state.status == LoadStatus.success && state.flag == "subCategory") {
            // hideProgress(context);
            showSubCategory(context, state.subCategoryList);
          }
          if (state.status == LoadStatus.success && state.flag == "delete") {
            hideProgress(context);
            Navigator.pushNamed(context, homeScreen);
          }
          if(state.status == LoadStatus.failure){
            hideProgress(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                    // child: Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     InkWell(
                    //         onTap: () {
                    //           Navigator.pop(context);
                    //         },
                    //         child: const Icon(Icons.arrow_back, color: AppIconColor.white)),
                    //     state.isEdit == true ? commonTextView(AddProductString.productDetails, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18) :
                    //     commonTextView("Add Product", fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18),
                    //     state.isEdit == true
                    //         ? Row(
                    //             children: [
                    //              state.isView == true ? const Offstage() : InkWell(
                    //                 onTap: () {
                    //                   context.read<AddProductBloc>().add(EditableProduct(isView: true));
                    //                 },
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(8.0),
                    //                   child: SvgPicture.asset(AppImages.editView, height: 20),
                    //                 ),
                    //               ),
                    //               InkWell(
                    //                 onTap: () {
                    //                   showAlertDialog(context,AddProductString.deleteProduct, AddProductString.areYouSure, CommonString.yes, onTapOk: () {
                    //                     Navigator.pop(context);
                    //                     context.read<AddProductBloc>().add(DeleteProductEvent(productModel: state.productModel));
                    //                   }, isShowCancel: true, cancelButtonText: CommonString.no);
                    //                 },
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(8.0),
                    //                   child: SvgPicture.asset(AppImages.delete, height: 20),
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         : const Offstage()
                    //   ],
                    // ),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back, color: AppIconColor.white)),
                            state.isEdit == true ? commonTextView(AddProductString.productDetails, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18) :
                            commonTextView("Add Product", fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18),
                            state.isEdit == true
                                ? Row(
                                    children: [
                                     state.isView == true ? const Offstage() : InkWell(
                                        onTap: () {
                                          context.read<AddProductBloc>().add(EditableProduct(isView: true));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 08,right: 08),
                                          child: SvgPicture.asset(AppImages.editView, height: 20),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showAlertDialog(context,AddProductString.deleteProduct, AddProductString.areYouSure, CommonString.yes, onTapOk: () {
                                            Navigator.pop(context);
                                            context.read<AddProductBloc>().add(DeleteProductEvent(productModel: state.productModel));
                                          }, isShowCancel: true, cancelButtonText: CommonString.no);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 08,right: 08),
                                          child: SvgPicture.asset(AppImages.delete, height: 20),
                                        ),
                                      ),
                                    ],
                                  )
                                : const Offstage()
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
            body: SingleChildScrollView(
              child: Container(
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  autovalidateMode: validate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      paddingTop(20),
                      customTextField(MediaQuery.of(context).size.width, AddProductString.productName, TextAlign.left, productName, (value) => validateProductName(value), focusNode[0], (value) => '', (value) {
                        FocusScope.of(context).requestFocus();
                      }, false, TextInputAction.next, TextInputType.name, TextCapitalization.none, AddProductString.enterProductName, context, '',
                          isShowTitle: true, titleStyle: TextStyleTheme.customTextStyle(AppTextColor.lightBlack, 18, FontWeight.w500), readOnly: state.isEdit == true ? !(state.isView!) : false),
                      paddingTop(15),
                      customTextField(
                          MediaQuery.of(context).size.width,
                          AddProductString.currentDate,
                          TextAlign.left,
                          productPurchaseDate,
                          (value) => null,
                          focusNode[1],
                          (value) => '',
                          (value) {
                            FocusScope.of(context).requestFocus();
                          },
                          false,
                          TextInputAction.next,
                          TextInputType.name,
                          TextCapitalization.none,
                          state.purchaseDate != null ? state.purchaseDate.toString() : outputFormat.format(DateTime.now()),
                          context,
                          (state.isEdit == true && state.isView == true) || state.isEdit == false  ? AppImages.calender : '',
                          onSuffixIconTap: () {
                            if(state.isEdit == true && state.isView == true){
                              showCalender(context, true);
                            }else if(state.isEdit == false){
                              showCalender(context, true);
                            }
                          },
                          isShowTitle: true,
                          titleStyle: TextStyleTheme.customTextStyle(AppTextColor.lightBlack, 18, FontWeight.w500),
                          readOnly: true),
                      paddingTop(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonTextView(AddProductString.category, color: AppTextColor.lightBlack, fontSize: 18, fontWeight: FontWeight.w500),
                          GestureDetector(
                              onTap: () {
                                if (state.isEdit == true && state.isView == true) {
                                  Navigator.pushNamed(context, allCategoryScreen, arguments: state.categoryList).then((value) {
                                    state.subCategoryModel = value as SubCategoryModel;
                                  });
                                } else if (state.isEdit == false) {
                                  Navigator.pushNamed(context, allCategoryScreen, arguments: state.categoryList).then((value) {
                                    state.subCategoryModel = value as SubCategoryModel;
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: commonTextView( (state.isEdit == true && state.isView == true) || state.isEdit == false ? AddProductString.viewAll : "", color: AppTextColor.lightGrey, fontSize: 16, fontWeight: FontWeight.w400),
                              )),
                        ],
                      ),
                      paddingTop(05),
                      state.subCategoryModel == null
                          ? SizedBox(
                              width: setWidth(500),
                              height: setHeight(110),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: (state.categoryList?.length ?? 0) > 5 ? 5 : (state.categoryList?.length ?? 0),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          context.read<AddProductBloc>().add(SelectedCategoryEvent(categoryModel: state.categoryList![index]));
                                        },
                                        child: commonCategoryCardView(state.categoryList?[index].categoryName, state.categoryList?[index].categoryImage));
                                  }),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppBackGroundColor.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 1),
                                      blurRadius: 5,
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 08),
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
                                          child: Image.network("${ApiUrls.imageUrl}${state.subCategoryModel?.categoryImage}"),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          commonTextView(state.subCategoryModel?.categoryName ?? '', fontWeight: FontWeight.w500, color: AppTextColor.blue, fontSize: 18),
                                          commonTextView(state.subCategoryModel?.subCategoryName ?? '', fontWeight: FontWeight.w500, color: AppTextColor.lightBlack, fontSize: 14),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      paddingTop(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: (){
                                showImagePicker(context);
                              },
                              child: commonTextView(AddProductString.warrantyCardPhoto, fontWeight: FontWeight.w500, color: AppTextColor.lightBlack, fontSize: 18)),
                          state.isEdit == true
                              ? GestureDetector(
                                  onTap: () {
                                    if (state.isEdit == true && state.isView == true) {
                                      state.productModel?.photo = '';
                                      showImagePicker(context);
                                    } else if (state.isEdit == false) {
                                      state.productModel?.photo = '';
                                      showImagePicker(context);
                                    }
                                  },
                                  child: commonTextView( (state.isEdit == true && state.isView == true) || state.isEdit == false  ? AddProductString.update : '', fontWeight: FontWeight.w500, color: AppTextColor.red, fontSize: 16))
                              : (state.isEdit == false && (state.productImage?.path.isNotEmpty ?? false))
                                  ? InkWell(
                                      onTap: () {
                                        context.read<AddProductBloc>().add(SelectedImageEvent(XFile('')));
                                      },
                                      child: commonTextView(AddProductString.removePhoto, fontWeight: FontWeight.w500, color: AppTextColor.red, fontSize: 16))
                                  : Container()
                        ],
                      ),
                      paddingTop(15),
                      state.isEdit == false
                          ? state.isEdit == false && (state.productImage?.path.isNotEmpty ?? false)
                              ? Container(
                                  height: 150,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(image: FileImage(File(state.productImage!.path)), fit: BoxFit.fitWidth),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                        child: GestureDetector(
                                          onTap: () {
                                            showImage(context, image: state.productImage!, imageUrl: '');
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              color: Colors.grey.withOpacity(0.1),
                                              child: commonTextView(AddProductString.viewPhoto, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 16)),
                                        )),
                                  ),
                                )
                              : Container(
                                  height: 160,
                                  decoration: const BoxDecoration(
                                      color: AppBackGroundColor.lightGrey,
                                      border: DashedBorder.fromBorderSide(dashLength: 5, side: BorderSide(color: AppBorderColor.lightBlue, width: 1)),
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                  child: Center(
                                      child: GestureDetector(
                                    onTap: () {
                                      showImagePicker(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      child: Column(
                                        children: [
                                          paddingTop(10),
                                          SvgPicture.asset(AppImages.gallery, color: AppIconColor.lightBlue, height: 40),
                                          paddingTop(05),
                                          commonTextView(AddProductString.uploadOrSelectPhoto, fontWeight: FontWeight.w500, color: AppTextColor.offBlue, fontSize: 15),
                                          paddingTop(05),
                                          commonTextView(AddProductString.supportSvg, fontWeight: FontWeight.w400, color: AppTextColor.lightGrey, fontSize: 12),
                                        ],
                                      ),
                                    ),
                                  )),
                                )
                          : Container(),
                      state.isEdit == true
                          ? (state.isEdit == true && state.productModel?.photo != '' && state.isNotification == false)
                              ? Container(
                                  height: 150,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image:DecorationImage(image: NetworkImage("${ApiUrls.imageUrl}${state.productModel?.photo}"), fit: BoxFit.fitWidth),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                        child: GestureDetector(
                                          onTap: () {
                                            showImage(context, imageUrl: state.productModel?.photo ?? '');
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              color: Colors.grey.withOpacity(0.1),
                                              child: commonTextView(AddProductString.viewPhoto, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 16)),
                                        )),
                                  ),
                                )
                              : state.isNotification == true ? Container(
                        height: 150,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image:DecorationImage(image: NetworkImage("${ApiUrls.imageUrl}${state.notificationModel?.photo}"), fit: BoxFit.fitWidth),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child: GestureDetector(
                                onTap: () {
                                  showImage(context, imageUrl: state.notificationModel?.photo ?? '');
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: commonTextView(AddProductString.viewPhoto, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 16)),
                              )),
                        ),
                      ) :    (state.productImage != null && state.isEdit == false)
                                  ? Container(
                                      height: 150,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(image: FileImage(File(state.productImage!.path)), fit: BoxFit.fitWidth),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                            child: GestureDetector(
                                              onTap: () {
                                                showImage(context, image: state.productImage!, imageUrl: '');
                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  color: Colors.grey.withOpacity(0.1),
                                                  child: commonTextView(AddProductString.viewPhoto, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 16)),
                                            )),
                                      ),
                                    )
                                  : (state.productImage != null && state.isEdit == true)
                                      ? Container(
                                          height: 150,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(image: FileImage(File(state.productImage!.path)), fit: BoxFit.fitWidth),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: BackdropFilter(
                                                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showImage(context, image: state.productImage!, imageUrl: '');
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      color: Colors.grey.withOpacity(0.1),
                                                      child: commonTextView(AddProductString.viewPhoto, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 16)),
                                                )),
                                          ),
                                        )
                                      : Container(
                                          height: 160,
                                          decoration: const BoxDecoration(
                                              color: AppBackGroundColor.lightGrey,
                                              border: DashedBorder.fromBorderSide(dashLength: 5, side: BorderSide(color: AppBorderColor.lightBlue, width: 1)),
                                              borderRadius: BorderRadius.all(Radius.circular(20))),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                            child: Column(
                                              children: [
                                                paddingTop(10),
                                                GestureDetector(
                                                    onTap: () {
                                                      showImagePicker(context);
                                                    },
                                                    child: SvgPicture.asset(AppImages.gallery, color: AppIconColor.lightBlue, height: 40)),
                                                paddingTop(05),
                                                commonTextView(AddProductString.uploadOrSelectPhoto, fontWeight: FontWeight.w500, color: AppTextColor.offBlue, fontSize: 15),
                                                paddingTop(05),
                                                commonTextView(AddProductString.supportSvg, fontWeight: FontWeight.w400, color: AppTextColor.lightGrey, fontSize: 12),
                                              ],
                                            ),
                                          )),
                                        )
                          : Container(),
                      paddingTop(15),
                      customTextField(MediaQuery.of(context).size.width, AddProductString.barcodeNumber, TextAlign.left, productBarcodeNumber, (value) => validateEmptyField(value), focusNode[2], (value) => '',
                          (value) {
                        FocusScope.of(context).requestFocus();
                      }, false, TextInputAction.next, TextInputType.name, TextCapitalization.none, "15862345786", context, '',
                          isShowTitle: true, titleStyle: TextStyleTheme.customTextStyle(AppTextColor.lightBlack, 18, FontWeight.w500), readOnly: state.isEdit == true ? !(state.isView!) : false),
                      paddingTop(15),
                      customTextField(
                          MediaQuery.of(context).size.width,
                          AddProductString.expiryDate,
                          TextAlign.left,
                          productExpiryDate,
                          (value) => null,
                          focusNode[3],
                          (value) => '',
                          (value) {
                            FocusScope.of(context).requestFocus();
                          },
                          false,
                          TextInputAction.next,
                          TextInputType.name,
                          TextCapitalization.none,
                          state.expiryDate != null ? state.expiryDate.toString() : outputFormat.format(DateTime.now()),
                          context,
                          (state.isEdit == true && state.isView == true) || state.isEdit == false ? AppImages.calender : '',
                          onSuffixIconTap: () {
                            if(state.isEdit == true && state.isView == true){
                              showCalender(context, false);
                            }else if(state.isEdit == false){
                              showCalender(context, false);
                            }
                          },
                          isShowTitle: true,
                          titleStyle: TextStyleTheme.customTextStyle(AppTextColor.lightBlack, 18, FontWeight.w500),
                          readOnly: true),
                      paddingTop(15),
                      TextFormField(
                        minLines: 4,
                        maxLines: 4,
                        controller: productDescription,
                        keyboardType: TextInputType.multiline,
                        readOnly: state.isEdit == true ? !(state.isView!) : false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            alignLabelWithHint: true,
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppBorderColor.lightBlue, width: 1), borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppBorderColor.darkGrey, width: 1), borderRadius: BorderRadius.circular(20)),
                            labelText: "Remark ",
                            labelStyle: TextStyleTheme.customTextStyle(AppTextColor.lightGrey, 14, FontWeight.w500)),
                      ),
                      paddingTop(15),
                      (state.isEdit == true && state.isView == true)
                          ? Row(
                              children: [
                                Expanded(
                                    child: commonButton(AddProductString.save, () {
                                      isImageCapture = false;
                                      if (formKey.currentState!.validate()) {
                                    if (productPurchaseDate.text.isEmpty) {
                                      awesomeTopSnackbar(context, AddProductString.pleaseSelectPurchaseDate);
                                    } else if (productExpiryDate.text.isEmpty) {
                                      awesomeTopSnackbar(context, AddProductString.pleaseSelectExpiryDate);
                                    } else if ((state.isEdit == false && state.productImage == null)) {
                                      awesomeTopSnackbar(context, AddProductString.pleaseSelectImage);
                                    } else if (state.subCategoryModel?.categoryId == null) {
                                      awesomeTopSnackbar(context, AddProductString.pleaseSelectCategory);
                                    } else if (state.subCategoryModel?.sId == null) {
                                      awesomeTopSnackbar(context, AddProductString.pleaseSelectSubCategory);
                                    } else {
                                      context.read<AddProductBloc>().add(AddProductsEvent(subCategoryModel: state.subCategoryModel));
                                    }
                                  }
                                }, 55)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: commonButton(AddProductString.discard, () {
                                  Navigator.pushNamed(context, homeScreen);
                                }, 55, buttonColor: AppButtonColor.lightGrey, textColor: AppTextColor.lightBlack)),
                              ],
                            )
                          : state.isEdit == false
                              ? Row(
                                  children: [
                                    Expanded(
                                        child: commonButton(AddProductString.save, () {
                                          isImageCapture = false;
                                          if (formKey.currentState!.validate()) {
                                        if (productPurchaseDate.text.isEmpty) {
                                          awesomeTopSnackbar(context, AddProductString.pleaseSelectPurchaseDate);
                                        } else if (productExpiryDate.text.isEmpty) {
                                          awesomeTopSnackbar(context, AddProductString.pleaseSelectExpiryDate);
                                        } else if ((state.isEdit == false && state.productImage == null)) {
                                          awesomeTopSnackbar(context, AddProductString.pleaseSelectImage);
                                        } else if (state.subCategoryModel?.categoryId == null) {
                                          awesomeTopSnackbar(context, AddProductString.pleaseSelectCategory);
                                        } else if (state.subCategoryModel?.sId == null) {
                                          awesomeTopSnackbar(context, AddProductString.pleaseSelectSubCategory);
                                        } else {
                                          context.read<AddProductBloc>().add(AddProductsEvent(subCategoryModel: state.subCategoryModel));
                                        }
                                      }
                                    }, 55)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: commonButton(AddProductString.discard, () {
                                      Navigator.pushNamed(context, homeScreen);
                                    }, 55, buttonColor: AppButtonColor.lightGrey, textColor: AppTextColor.lightBlack)),
                                  ],
                                )
                              : const Offstage(),
                      paddingBottom(30)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ///Check Camera Permission
  Future<bool> permissionCheck() async {
    final status = await Permission.camera.status;
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
    final result = await Permission.camera.request();
    return result == PermissionStatus.granted;
  }

  ///Show Image Picker
  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      enableDrag: false,
      builder: (BuildContext context1) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              isImageCapture = true;
                              Navigator.pop(context);
                              permissionCheck().then((value) async {
                                if (value) {
                                  final ImagePicker picker = ImagePicker();
                                  picker.pickImage(source: ImageSource.camera).then((value) async{
                                    CroppedFile? croppedFile = await ImageCropper().cropImage(
                                      sourcePath: value!.path,
                                      uiSettings: [
                                        AndroidUiSettings(
                                            toolbarColor: AppBackGroundColor.blue,
                                            toolbarWidgetColor: AppBackGroundColor.white,
                                            initAspectRatio: CropAspectRatioPreset.original,
                                            lockAspectRatio: false),
                                        IOSUiSettings(
                                          title: 'Cropper',
                                        ),
                                      ],
                                    );
                                    if (croppedFile != null) {
                                      context.read<AddProductBloc>().add(SelectedImageEvent(XFile(croppedFile.path)));
                                    }
                                  });
                                }
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: AppBackGroundColor.darkGrey,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(padding: const EdgeInsets.all(15), child: SvgPicture.asset(AppImages.bottomCamera)),
                            ),
                          ),
                          const Text(CommonString.takePicture)
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              isImageCapture = true;
                              Navigator.pop(context);
                              permissionCheck().then((value) async {
                                if (value) {
                                  final ImagePicker picker = ImagePicker();
                                  picker.pickImage(
                                      source: ImageSource.gallery).then((value) async {
                                    CroppedFile? croppedFile = await ImageCropper().cropImage(
                                      sourcePath: value!.path,
                                      uiSettings: [
                                        AndroidUiSettings(
                                            toolbarColor: AppBackGroundColor.blue,
                                            toolbarWidgetColor: AppBackGroundColor.white,
                                            initAspectRatio: CropAspectRatioPreset.original,
                                            lockAspectRatio: false),
                                        IOSUiSettings(
                                          title: CommonString.cropImage,
                                        ),
                                      ],
                                    );
                                    if (croppedFile != null) {
                                      context.read<AddProductBloc>().add(SelectedImageEvent(XFile(croppedFile.path)));
                                    }
                                  });
                                }
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: AppBackGroundColor.darkGrey,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(padding: const EdgeInsets.all(15), child: SvgPicture.asset(AppImages.gallery)),
                            ),
                          ),
                          const Text(CommonString.choosePicture)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              paddingTop(10),
            ],
          ),
        );
      },
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
            child: subcategory?.isNotEmpty ?? false
                ? ListView.separated(
                    shrinkWrap: true,
                    itemCount: subcategory?.length ?? 0,
                    itemBuilder: (contexts, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          context.read<AddProductBloc>().add(SelectedSubCategoryEvent(subCategoryModel: subcategory?[index]));
                        },
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: commonTextView(subcategory?[index].subCategoryName ?? '', fontWeight: FontWeight.w500, color: AppTextColor.lightBlack, fontSize: 18)),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  )
                : const Text(CategoryString.noSubCategory),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    productName.clear();
    productPurchaseDate.clear();
    productExpiryDate.clear();
    productDescription.clear();
    productBarcodeNumber.clear();
    super.dispose();
  }

}

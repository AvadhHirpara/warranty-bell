import 'dart:io';
import 'package:WarrantyBell/Model/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Constants/app_date_formates.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/user_data_model.dart';
import 'package:WarrantyBell/Pages/HomeScreen/Module/common_rich_text.dart';
import 'package:WarrantyBell/Pages/HomeScreen/home_bloc.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:WarrantyBell/Utils/Mixins/alert_dialog.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:WarrantyBell/main.dart';
import 'package:WarrantyBell/utils/Mixins/app_exit_dialog.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:WarrantyBell/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lecle_downloads_path_provider/constants/downloads_directory_type.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeInitialEvent());
    super.initState();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == LoadStatus.loading) {
            showProgressThreeDots(context, loaderColor: AppBackGroundColor.blue);
          } else if (state.status == LoadStatus.success && state.flag == "product") {
            hideProgress(context);
          } else if (state.status == LoadStatus.success && state.flag == "logout") {
            hideProgress(context);
            userData = UserData();
            userData.authToken = null;
            sharedPref.removeAll();
            Navigator.pushNamedAndRemoveUntil(context, login, (route) => false);
          }  else if (state.status == LoadStatus.failure) {
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
                key: scaffoldKey,
                appBar: PreferredSize(
                    preferredSize: const Size(100, 100),
                    child: customAppBar(onTapMenuBar: () => scaffoldKey.currentState!.openEndDrawer(), onTapNotification: () {
                      setState(() {
                        globalVariable.isNotificationArrive = false;
                      });
                      Navigator.pushNamed(context, notificationScreen);
                    })),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    child: Column(
                      children: [
                        state.productsList?.isNotEmpty ?? false ?  Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(05),
                                border: Border.all(width: 1,color: AppBorderColor.grey.withOpacity(0.1))
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        context.read<HomeBloc>().add(ChangeTabEvent(isSelectProduct: true,isSelectCategories: false));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(05),
                                          gradient: LinearGradient(
                                                      end: Alignment.centerRight,
                                              colors: state.isSelectProduct == true ? <Color>[AppBarColor.lightBlue,AppBarColor.blue] : <Color>[AppBackGroundColor.white,AppBackGroundColor.white]),
                                        ),
                                        child: Text(HomeString.myProduct,style: TextStyleTheme.customTextStyle(state.isSelectProduct == true ? AppTextColor.white : AppTextColor.black, 16, FontWeight.w500),),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        context.read<HomeBloc>().add(ChangeTabEvent(isSelectProduct: false,isSelectCategories: true));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(05),
                                          gradient: LinearGradient(
                                              end: Alignment.centerRight,
                                              colors: state.isSelectCategories == true ? <Color>[AppBarColor.lightBlue,AppBarColor.blue] : <Color>[AppBackGroundColor.white,AppBackGroundColor.white]),
                                        ),
                                        child: Text(HomeString.categories,style: TextStyleTheme.customTextStyle(state.isSelectCategories == true ? AppTextColor.white : AppTextColor.black, 16, FontWeight.w500),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            state.isSelectProduct == true ? state.productsList?.isNotEmpty ?? false
                                ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.productsList?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, addProductScreen, arguments: {"productModel": state.productsList?[index], "isEdit": true,"isView" : false,"isNotification" : false});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 05),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppBackGroundColor.white,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              offset: const Offset(0, 1),
                                              blurRadius: 2,
                                              spreadRadius: 2,
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(90),),
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
                                                      GestureDetector(
                                                          onTap: (){
                                                            // createPDF(state.productsList![index]).then((value){
                                                            //   print("download path is $value");
                                                            // });
                                                            createPDF(state.productsList![index]);
                                                          },
                                                          child: const Align(
                                                              alignment: Alignment.centerRight,
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: 05),
                                                                child: Icon(Icons.download_rounded,color: AppIconColor.blue,),
                                                              )) /*commonRichText("Download pdf", '')*/),
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
                                })
                                : const Offstage() : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.categoryList?.length ?? 0,
                                itemBuilder: (BuildContext contexts,index){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 05),
                                    child: GestureDetector(
                                      onTap: (){
                                        if(state.categoryList?[index].productCount != 0){
                                          Navigator.pushNamed(contexts, categoryProduct, arguments: {"categoryId" : state.categoryList?[index].sId});
                                        }
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
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
                                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 05),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
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
                                                      child: Image.network("${ApiUrls.imageUrl}${state.categoryList?[index].categoryImage}" ?? '',color: AppIconColor.white),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  commonTextView(state.categoryList?[index].categoryName ?? '',fontWeight: FontWeight.w500,color: AppTextColor.blue,fontSize: 18,overflow: TextOverflow.ellipsis,maxLines: 1),
                                                ],
                                              ),
                                              state.categoryList?[index].productCount != 0 ?   Container(
                                                alignment: Alignment.center,
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  color: AppBackGroundColor.darkGrey,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child:commonTextView(state.categoryList?[index].productCount.toString() ?? '',fontWeight: FontWeight.w500,color: AppTextColor.blue,fontSize: 16),
                                              ) : const Offstage()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ) : const Offstage(),
                        state.productsList?.isEmpty ?? false
                            ? Column(
                          children: [
                            paddingTop(100),
                            Container(
                              height: 300,
                              decoration: const BoxDecoration(
                                  color: AppBackGroundColor.lightGrey,
                                  border: DashedBorder.fromBorderSide(dashLength: 5, side: BorderSide(color: AppBorderColor.lightBlue, width: 1)),
                                  borderRadius: BorderRadius.all(Radius.circular(15))),
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context, addProductScreen, arguments: {"isEdit": false,"isView" : false,"isNotification" : false});
                                          },
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppBackGroundColor.blue),
                                            child: const Icon(Icons.add, color: AppIconColor.white, size: 30),
                                          ),
                                        ),
                                        paddingTop(05),
                                        commonTextView(HomeString.addProductDetails, fontWeight: FontWeight.w500, color: AppTextColor.offBlue, fontSize: 18),
                                        paddingTop(05),
                                        commonTextView(HomeString.notAddedAnyProduct, fontWeight: FontWeight.w400, color: AppTextColor.lightGrey, fontSize: 12),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        )
                            : const Offstage(),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: state.productsList?.isNotEmpty ?? false
                    ?  GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, addProductScreen, arguments: {"isEdit": false,"isView" : false,"isNotification" : false});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppBackGroundColor.lightBlue,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(Icons.add, color: AppIconColor.white),
                        ),
                      )
                    : const Offstage(),
                endDrawer: Drawer(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(end: Alignment.centerRight, colors: <Color>[AppBarColor.lightBlue, AppBarColor.blue]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 45,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: userData.profile != '' ? "${ApiUrls.imageUrl}${userData.profile}" : "https://i.pinimg.com/564x/de/6e/8d/de6e8d53598eecfb6a2d86919b267791.jpg",
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  commonTextView(userData.firstName ?? '', fontSize: 20, fontWeight: FontWeight.w600, color: AppTextColor.white,maxLines: 1,overflow: TextOverflow.ellipsis),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, editProfileScreen);
                                      },
                                      child: commonTextView(CommonString.viewProfile, fontSize: 14, fontWeight: FontWeight.w600, color: AppTextColor.white)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(CommonString.notificationSchedule,
                          style: TextStyleTheme.customTextStyle(AppTextColor.lightBlack, 16, FontWeight.w500),
                        ),
                        leading: SvgPicture.asset(AppImages.notificationSchedule),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, notificationScheduleScreen);
                        },
                      ),
                      ListTile(
                        title: Text(CommonString.productHistory,
                          style: TextStyleTheme.customTextStyle(AppTextColor.lightBlack, 16, FontWeight.w500),
                        ),
                        leading: SvgPicture.asset(AppImages.productHistory),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, productHistory);
                        },
                      ),
                      ListTile(
                        title: Text(
                          CommonString.setting,
                          style: TextStyleTheme.customTextStyle(AppTextColor.lightBlack, 16, FontWeight.w500),
                        ),
                        leading: SvgPicture.asset(AppImages.setting),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, settingScreen);
                        },
                      ),
                      const Spacer(),
                      ListTile(
                        title: Text(
                          CommonString.logout,
                          style: TextStyleTheme.customTextStyle(AppTextColor.lightBlack, 16, FontWeight.w500),
                        ),
                        leading: SvgPicture.asset(AppImages.logout),
                        onTap: () {
                          Navigator.pop(context);
                          showAlertDialog(context, CommonString.logout, CommonString.areYouSureLogout, CommonString.yes, onTapOk: () {
                            Navigator.pop(context);
                            context.read<HomeBloc>().add(LogoutEvent());
                          }, isShowCancel: true, cancelButtonText: CommonString.no);
                        },
                      ),
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

  PdfDocument document = PdfDocument();

  Future<String> createPDF(Datum productData) async {
    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 2);

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = HomeString.productName;
    row.cells[1].value = productData.productName;

    row = grid.rows.add();
    row.cells[0].value = HomeString.category;
    row.cells[1].value = "${productData.categoryName}${"(${productData.subCategoryName})"}";

    row = grid.rows.add();
    row.cells[0].value = HomeString.currentDate;
    row.cells[1].value = outputFormat.format(productData.purchaseDate!);

    row = grid.rows.add();
    row.cells[0].value = HomeString.warrantyDate;
    row.cells[1].value = outputFormat.format(productData.warrantyExpiryDate!);

    row = grid.rows.add();
    row.cells[0].value = HomeString.barcodeNumber;
    row.cells[1].value = productData.barcodeNumber.toString();

    row = grid.rows.add();
    row.cells[0].value = HomeString.remark;
    row.cells[1].value = productData.remark;

    grid.draw(page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    var file;
    final PathProviderPlatform provider = PathProviderPlatform.instance;

    if(Platform.isAndroid){
      Directory?  documents = await DownloadsPath.downloadsDirectory(dirType: DownloadDirectoryTypes.downloads);
      file = File('${documents!.path}/${DateTime.now().microsecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await document.save());
    }else if(Platform.isIOS){
      String? documents = await provider.getDownloadsPath();
      file = File('$documents/${DateTime.now().microsecondsSinceEpoch}.pdf');
      file.writeAsBytes(await document.save());
    }

    return file.path;
  }

}
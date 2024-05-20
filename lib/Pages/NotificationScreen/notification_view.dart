import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/app_date_formates.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/NotificationScreen/notification_bloc.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(NotificationInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { FocusScope.of(context).requestFocus(FocusNode()); },
      child: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if(state.status == LoadStatus.loading){
            showProgressThreeDots(context);
          }else if(state.status == LoadStatus.success && state.flag == "notification"){
            hideProgress(context);
          }else if(state.status == LoadStatus.success && state.flag == "delete"){
            hideProgress(context);
            Navigator.pushNamed(context, homeScreen);
          }
          else if(state.status == LoadStatus.failure){
            hideProgress(context);
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () => Future(() => false),
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size(100, 150),
                  child: Container(
                    padding: const EdgeInsets.only(top: 65),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            end: Alignment.centerRight,
                            colors: <Color>[AppBarColor.lightBlue,AppBarColor.blue]),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight : Radius.circular(10),)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0,
                              right: 0,
                              child: commonTextView(NotificationString.notification, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18)),
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back,color: AppIconColor.white)),
                        ],
                      ),
                    ),
                  )),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      paddingTop(30),
                      state.notifications?.isNotEmpty ?? false ?  ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.notifications?.length ?? 0,
                        itemBuilder: (context, index){
                        return SwipeActionCell(
                          key: ObjectKey(state.notifications?[index]),
                          trailingActions: <SwipeAction>[
                            SwipeAction(
                                icon: SvgPicture.asset(AppImages.delete),
                                onTap: (CompletionHandler handler) {
                                  context.read<NotificationBloc>().add(DeleteNotificationEvent(notificationModel: state.notifications?[index]));
                                },
                                backgroundRadius: 15,
                                color: AppBackGroundColor.red),
                          ],

                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, addProductScreen, arguments: {"notificationModel": state.notifications?[index], "isEdit": true,"isView" : false,"isNotification" : true});
                              context.read<NotificationBloc>().add(UpdateNotificationEvent(notificationModel: state.notifications?[index]));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 08),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppImages.dot,width: 10,color: state.notifications![index].isViewed == true ? AppTextColor.grey : AppIconColor.blue),
                                      const SizedBox(width: 10),
                                      commonTextView(state.notifications?[index].title ?? '',fontSize: 16,color:state.notifications![index].isViewed == true ? AppTextColor.grey : AppTextColor.lightBlack,fontWeight: FontWeight.w500),
                                      const Spacer(),
                                      commonTextView(outputFormat.format(DateTime.parse(state.notifications![index].createdAt!)),fontSize: 12,color: state.notifications![index].isViewed == true ? AppTextColor.grey : AppTextColor.offGrey,fontWeight: FontWeight.w500),
                                      const SizedBox(width: 05)
                                    ],
                                  ),
                                  commonTextView(state.notifications?[index].notificationMessage ?? '',fontSize: 15,color: state.notifications![index].isViewed == true ? AppTextColor.grey : AppTextColor.darkBlue ,fontWeight: FontWeight.w400,maxLines: 2,align: TextAlign.start),
                                ],
                              ),
                            ),
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                      },) : Center(child: commonTextView(NotificationString.noNotification))
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
}
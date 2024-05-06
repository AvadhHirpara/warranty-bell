import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/NotificationScheduleScreen/notification_schedule_bloc.dart';
import 'package:WarrantyBell/Pages/SettingScreen/Module/common_setting_item_view.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScheduleScreen extends StatefulWidget {
  const NotificationScheduleScreen({super.key});

  @override
  State<NotificationScheduleScreen> createState() => _NotificationScheduleScreenState();
}

class _NotificationScheduleScreenState extends State<NotificationScheduleScreen> {

  @override
  void initState() {
    super.initState();
    context.read<NotificationScheduleBloc>().add(NotificationInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocConsumer<NotificationScheduleBloc, NotificationScheduleState>(
        listener: (context, state) {
          if (state.status == LoadStatus.loading) {
            showProgressThreeDots(context, loaderColor: AppBackGroundColor.blue);
          } else if (state.status == LoadStatus.success) {
            hideProgress(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size(100, 100),
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
                        Expanded(child: commonTextView("Notification Schedule", fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18)),
                      ],
                    ),
                  ),
                )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    paddingTop(30),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.notificationScheduleList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: commonSettingItemView("${state.notificationScheduleList?[index].timePeriod.toString()} Days" ?? '',
                                child: SvgPicture.asset((state.notificationScheduleList?[index].status == false) ? AppImages.unSelectRadio : AppImages.selectedRadio), onTap: () {
                              context.read<NotificationScheduleBloc>().add(ChangeNotificationStatusEvent(notificationScheduleModel: state.notificationScheduleList?[index], isStatus: !state.notificationScheduleList![index].status!));
                            }),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

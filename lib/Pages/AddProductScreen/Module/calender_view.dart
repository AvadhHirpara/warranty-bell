import 'package:WarrantyBell/Constants/app_date_formates.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

///ShowCalenderView
showCalender(BuildContext context,bool selectMfgDate){
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppBackGroundColor.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SfDateRangePicker(
                showNavigationArrow: true,
                  headerStyle: DateRangePickerHeaderStyle(textStyle: TextStyleTheme.customTextStyle(AppTextColor.blue, 18, FontWeight.w500),textAlign: TextAlign.center),
                  selectionRadius: 20,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args){
                  if(selectMfgDate == true){
                    productPurchaseDate.text = outputFormat.format(args.value);
                  }else{
                    productExpiryDate.text = outputFormat.format(args.value);
                  }
                    Navigator.pop(context);
                  },
                  selectionMode: DateRangePickerSelectionMode.single),
            ],
          ),
        ),
      );
    },
  );
}
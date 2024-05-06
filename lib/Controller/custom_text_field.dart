import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Element/responsive_size_value.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
///Custom TextField
Widget customTextField(
    double width,
    String title,
    TextAlign align,
    TextEditingController controller,
    FormFieldValidator validator,
    FocusNode focusNode,
    FormFieldSetter onSave,
    ValueChanged<String>? submit,
    bool obSecure,
    TextInputAction textInputAction,
    TextInputType textInputType,
    TextCapitalization textCapitalization,
    String textHint,
    BuildContext context,
    String icon,
{
  Key? key,
  int line =1,
  int? maxlength,
  Function(String)? onChange,
  Function()? onTap,
  VoidCallback? onEditingComplete,
  VoidCallback? onSuffixIconTap,
  VoidCallback? onPrefixIconTap,
  Color? cursorColor,
  Color? errorTextColor,
  TextStyle? titleStyle,
  TextStyle? inputStyle,
  TextStyle? hintStyle,
  Color? borderColor,
  Color? focusColor,
  bool? readOnly,
  EdgeInsets? contentPadding,
  String? labelText,
  String? prefixIcon = '',
  bool? isShowTitle = false
}) {
  return SizedBox(
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isShowTitle == false ? Container() : Padding(padding: const EdgeInsets.only(bottom: 5),
        child: Text(title,style: titleStyle ?? TextStyleTheme.customTextStyle(AppTextColor.black,18, FontWeight.w400),),),
        TextFormField(
          key: key,
          validator: validator,
          textAlignVertical: TextAlignVertical.center,
          textAlign: align,
          autovalidateMode: AutovalidateMode.disabled,
          controller: controller,
          focusNode: focusNode,
          onSaved: onSave,
          maxLines: line,
          maxLength: maxlength,
          readOnly: readOnly ?? false,
          onFieldSubmitted: submit,
          obscureText: obSecure,
          obscuringCharacter: "*",
          onTap: onTap,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          textCapitalization: textCapitalization,
          onChanged: onChange,
          // enabled: !(readOnly ?? false),
          onEditingComplete: onEditingComplete,
          style: inputStyle ?? TextStyleTheme.customTextStyle(AppTextColor.grey, 16, FontWeight.w400),
          cursorColor: cursorColor ?? AppBackGroundColor.grey,
          decoration:InputDecoration(
            fillColor: AppBackGroundColor.lightGrey,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            labelStyle: TextStyleTheme.customTextStyle(AppTextColor.grey, 14, FontWeight.w500),
            counterText: '',
            isCollapsed: false,
            isDense: true,
            prefixIcon: prefixIcon.toString().isNotEmpty ? GestureDetector(
              onTap: onPrefixIconTap,
              child: Padding(
                padding: EdgeInsets.all(setSp(15)),
                child: SvgPicture.asset(prefixIcon.toString()),
              ),
            ) : null,
            labelText: labelText,
            contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: setSp(10),vertical: setSp(10)),
            suffixIcon: icon.isNotEmpty ? GestureDetector(
              onTap: onSuffixIconTap,
              child: Padding(
                padding: EdgeInsets.all(setSp(14)),
                child: SvgPicture.asset(icon),
              ),
            ) : Padding(padding: EdgeInsets.all(setSp(10)),child: SizedBox(height: setSp(14),width: setSp(14),),),
            hintText: textHint,
            focusColor: focusColor ?? AppBorderColor.black,
            errorStyle: TextStyleTheme.customTextStyle(AppTextColor.red, 12,FontWeight.w500),
            hintStyle: hintStyle ?? TextStyleTheme.customTextStyle(AppTextColor.grey, 16, FontWeight.w400),
            // errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(08),borderSide:BorderSide(color: borderColor ?? AppBorderColor.grey,width: 0.9)),
            // disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(08),borderSide:BorderSide(color: borderColor ?? AppBorderColor.grey,width: 0.9)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(08),borderSide:BorderSide(color: borderColor ?? AppBorderColor.blue,width: 0.9)),
            // focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(08),borderSide:BorderSide(color: borderColor ?? AppBorderColor.red,width: 0.9)),
            // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(08),borderSide:BorderSide(color: borderColor ?? AppBorderColor.black,width: 0.9))
          ),
        )
      ],
    ),
  );

}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Domain/ChangeLanguage/language_cubit.dart';
getAlignText(title , context){
  var w = MediaQuery.of(context).size.width;
  return Align(
    alignment: ChangeLanguageCubit.get(context).isEnglish ?  Alignment.centerLeft : Alignment.centerRight,
    child: Container(
      margin: EdgeInsets.only(
          top: 8.sp,
          left: w > 600 ? w*0.2 : 14.sp,
          right: 14.sp
      ),
      child: Text(
        title,
        style: UserTheme.get(
            context: context,
            fontSize:  w > 600 ? 12.sp : 14.sp,
            fontWight: FontWeight.w600,
            colorBright: black,
            colorDark: white
        ),
      ),
    ),
  );
}
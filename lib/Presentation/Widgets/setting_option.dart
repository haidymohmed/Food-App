import 'package:flutter/material.dart';
import 'package:restaurant_app/Constants/user_responsive.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';

getSettingOption({required title, required icon, required islast, onTap ,required context}){
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: Container(
          margin: UserResponsive.get(
            context: context,
            mobile: null,
            tablet: EdgeInsets.symmetric(
              horizontal: 10.sp,
              vertical: 5.sp
            )
          ),
          child: ListTile(
            title: Text(
              title,
              style: UserTheme.get(
                  context: context,
                  fontSize: UserResponsive.get(
                    context: context,
                    mobile: 15.sp,
                    tablet: 10.sp
                  ),
                  fontWight: FontWeight.w600,
                  colorBright: black,
                  colorDark: white
              )
            ),
            trailing: icon.runtimeType == IconData? Icon(
              icon ,
              color: green,
              size: UserResponsive.get(
                  context: context,
                  mobile: 15.sp,
                  tablet: 10.sp
              ),
            ) : icon ,
          ),
        ),
      ),
      islast ?   Container() : Divider(
        height: 5.sp,
        color: Colors.grey.shade300,
      ),
    ],
  );
}
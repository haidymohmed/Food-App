import 'package:flutter/material.dart';
import 'package:restaurant_app/Constants/user_responsive.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';

getChangeTextField({required String? title ,required context ,  onValidate , onSave , contraller , }){
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10.sp),
        child: TextFormField(
          style: UserTheme.get(
              context: context,
              fontWight: FontWeight.w500,
              fontSize: UserResponsive.get(context: context, mobile: 13.sp, tablet: 10.sp),
              colorBright: black,
              colorDark: Colors.white
          ) ,
          onSaved: onSave,
          controller: contraller,
          validator: onValidate,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: UserTheme.get(
              context: context,
              fontWight: FontWeight.w500,
              fontSize: UserResponsive.get(context: context, mobile: 13.sp, tablet: 10.sp),
              colorBright: black,
              colorDark: Colors.grey.shade600
            ),
            border: const OutlineInputBorder(
                borderSide: BorderSide.none
            ),
          ),
        ),
      ),
      const Divider()
    ],
  );
}
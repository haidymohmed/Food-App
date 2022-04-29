import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/user_responsive.dart';
import '../../Domain/DarkTheme.dart';
import '../../Language/locale_keys.g.dart';
getAppBar({required context ,required perffix ,required suffix ,required title}){
  return PreferredSize(
    preferredSize: Size(
        MediaQuery.of(context).size.width * 0.9 , UserResponsive.get(
          context: context,
          mobile: 100.sp,
          tablet: 80.sp
      )
    ),
    child: Container(
      margin: EdgeInsets.symmetric(
          horizontal: 10.sp,
          vertical: 15.sp
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 5.sp,
        vertical: UserResponsive.get(context: context, mobile: 10.sp, tablet: 8.sp)
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade800 :  Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          perffix,
          Text(
            title,
            textAlign: TextAlign.center,
            style: UserTheme.get(
                context: context,
                fontSize: UserResponsive.get(
                  context: context,
                  mobile: 17.sp,
                  tablet: 12.sp
                ),
                fontWight: FontWeight.w700,
                colorBright: black,
                colorDark: Colors.grey.shade300
            )
          ),
          suffix
        ],
      ),
    ),
  );
}
getHomeAppBar({required index , key , required context}){
  return getAppBar(
      title: getTitle(index),
      context: context,
      perffix: getLeading(index : index ,key : key , context: context),
      suffix: getTail(index , context),
  );
}

getTitle(index){
  switch(index){
    case 1 :
      return LocaleKeys.favorite.tr();
    case 2 :
      return LocaleKeys.orderDetail.tr();
    case 3 :
      return LocaleKeys.setting.tr();
    default :
      return LocaleKeys.home.tr();
  }
}
getLeading({required index , key , required context}){
  switch(index){
    case 1 :
    case 2 :
    case 3 :
      return InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          size: UserResponsive.get(
              context: context,
              mobile: 17.sp,
              tablet: 13.sp
          ),
        )
      );
    default :
        return InkWell(
          onTap: (){
            key.currentState!.openDrawer();
          },
          child: Icon(
            Icons.menu ,
            color: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade300 : Colors.black,
            size: UserResponsive.get(
                context: context,
                mobile: 20.sp,
                tablet: 15.sp
            ),
          )
      );
  }
}
getTail(index , context){
  switch(index){
    case 1 :
    case 3 :
      return SizedBox(width: 25.sp,);
    case 2 :
      return InkWell(
          onTap: (){},
          child: Icon(
            Icons.help , color:Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade300 : Colors.black,
            size: UserResponsive.get(
              context: context,
              mobile: 17.sp,
              tablet: 13.sp
          ),
          )
      );
    default :
      return
        InkWell(
            onTap: (){},
            child: Icon(
              Icons.search ,
              color: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade300 :Colors.black,
              size: UserResponsive.get(
                  context: context,
                  mobile: 17.sp,
                  tablet: 13.sp
              ),
            )
        );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Constants/user_responsive.dart';
import 'package:restaurant_app/Language/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Constants/route_id.dart';
import '../../Constants/user_info.dart';
import '../../Domain/DarkTheme.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/setting_option.dart';
class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    int splitNameLength = customerData.name!.split(" ").length;
    return SafeArea(
          child: Scaffold(
            backgroundColor:  Provider.of<UserDarkTheme>(context).isDark? null  : background,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  getAppBar(
                    context : context,
                    perffix :InkWell(
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
                    ),
                    suffix : SizedBox(width: 25.sp,),
                    title : LocaleKeys.accountInformation.tr()
                  ),
                  CircleAvatar(
                    radius: 29.sp,
                    backgroundImage: AssetImage(profilePic),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 17.sp,
                        bottom: 16.sp
                    ),
                    child: Text(
                      "Change Profile Picture",
                      style: UserTheme.get(
                        context: context,
                        fontSize: 13.sp,
                        fontWight: FontWeight.w600,
                        colorBright: null,
                        colorDark: null
                      ),
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  getList(
                    title: LocaleKeys.email.tr() ,
                    subtitle: customerData.email,
                      context: context
                  ),
                  getList(
                      title: LocaleKeys.firstName.tr() ,
                      subtitle: customerData.name!.split(" ").sublist(0, 1).join(" "),
                      context: context
                  ),
                  getList(
                      title: LocaleKeys.lastName.tr(),
                      subtitle: customerData.name!.split(" ").sublist(1, splitNameLength).join(" "),
                    context: context
                  ),
                  getSettingOption(
                       title: LocaleKeys.changeEmail.tr(),
                      context: context,
                       icon : Icons.arrow_forward_ios_outlined ,
                       islast: false ,
                       onTap: (){
                         Navigator.pushNamed(context, changeEmail);
                       }
                   ),
                  getSettingOption(
                      title: LocaleKeys.changePassword.tr(),
                      context: context,
                      icon : Icons.arrow_forward_ios_outlined ,
                      islast: false ,
                      onTap: (){
                        Navigator.pushNamed(context, changePass);
                      }
                  ),
                  SizedBox(height: 15.sp,),
                  Container(
                    padding: EdgeInsets.all(
                        UserResponsive.get(
                          context: context,
                          mobile: 5.sp,
                          tablet: 5.sp
                        )
                    ),
                    margin: UserResponsive.get(
                        context: context,
                        mobile: null,
                        tablet: EdgeInsets.symmetric(horizontal: 20.sp)
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade600 : Colors.grey.shade400,
                    ),
                    child: ToggleSwitch(
                      initialLabelIndex: 0,
                      totalSwitches: 2,
                      labels:  [LocaleKeys.male.tr() , LocaleKeys.feMale.tr()],
                      customWidths: [
                        UserResponsive.get(
                            context: context,
                            mobile: UserResponsive.width(context) * 0.40,
                            tablet: UserResponsive.width(context) * 0.35
                        ),
                        UserResponsive.get(
                            context: context,
                            mobile: UserResponsive.width(context) * 0.40,
                            tablet: UserResponsive.width(context) * 0.35
                        ),
                      ],
                      minHeight: UserResponsive.get(
                        context: context,
                        mobile : 30.sp,
                        tablet: 23.sp
                      ),
                      radiusStyle: true,
                      activeBgColor: [
                        Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade800 : white ,
                        Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade800 : white ,
                      ],
                      inactiveBgColor: Provider.of<UserDarkTheme>(context).isDark?  Colors.grey.shade600 : Colors.grey.shade400,
                      customTextStyles: [
                        UserTheme.get(
                            context: context,
                            fontSize: UserResponsive.get(
                                context: context,
                                mobile: 15.sp,
                                tablet: 11.sp
                            ),
                            fontWight: FontWeight.w600,
                            colorBright: null,
                            colorDark: null
                        ),
                        UserTheme.get(
                            context: context,
                            fontSize: UserResponsive.get(
                                context: context,
                                mobile: 15.sp,
                                tablet: 11.sp
                            ),
                            fontWight: FontWeight.w600,
                            colorBright: null,
                            colorDark: null
                        ),
                      ],
                      onToggle: (index) {
                        print('switched to: $index');
                      },
                    ),
                  ),
                  SizedBox(height: 20.sp,)
                ],
              ),
            ),
          ),
    );
  }
  getList({required title , required subtitle , required context}){
    return Container(
      width: MediaQuery.of(context).size.width ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 25.sp
            ),
            child: Text(
              title,
              style: UserTheme.get(
                  context: context,
                  fontSize: UserResponsive.get(context: context, mobile: 14.sp, tablet: 11.sp),
                  fontWight: FontWeight.w600,
                  colorBright: Colors.grey,
                  colorDark: Colors.grey.shade400
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 25.sp
            ),
            child: Text(
              subtitle,
              style:  UserTheme.get(
                  context: context,
                  fontSize: UserResponsive.get(context: context, mobile: 15.sp, tablet: 11.sp),
                  fontWight: FontWeight.w600,
                  colorBright: black,
                  colorDark: Colors.grey.shade100
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

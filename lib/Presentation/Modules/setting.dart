import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Constants/route_id.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/user_info.dart';
import '../../Constants/user_responsive.dart';
import '../../Domain/DarkTheme.dart';
import '../../Language/locale_keys.g.dart';
import '../Dialogs/showLanguage.dart';
import '../Widgets/setting_option.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: UserResponsive.get(
                    context: context,
                    mobile: 30.sp,
                    tablet: 30.sp
                ),
                backgroundImage: const AssetImage(profilePic),
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Haidy Mohmed",
            textAlign: TextAlign.center,
            style: UserTheme.get(
              context : context,
                fontSize: UserResponsive.get(
                    context: context,
                    mobile: 15.sp,
                    tablet: 9.sp
                ),
                fontWight: FontWeight.w900,
              colorDark: white,
              colorBright: black
            ),
          ),
        ),
        Text(
          customerData.email,
          textAlign: TextAlign.center,
          style : UserTheme.get(
              context : context,
              fontSize: UserResponsive.get(
                  context: context,
                  mobile: 13.sp,
                  tablet: 8.sp
              ),
              fontWight: FontWeight.w500,
              colorDark: white,
              colorBright: black
          ),
        ),
        SizedBox(height: 5.sp,),
        getSettingOption(
            title: LocaleKeys.accountInformation.tr() ,
            icon : Icons.arrow_forward_ios_outlined ,
            islast: false ,
            context: context,
            onTap: (){
            Navigator.pushNamed(context, accountInfoPath);
          }
        ),
        getSettingOption(
            title: LocaleKeys.addressInformation.tr()  ,
            icon :Icons.arrow_forward_ios_outlined ,
            context: context,
            islast: false ,
          onTap: (){
              Navigator.pushNamed(context, addressInfoPath);
          }
        ),
        getSettingOption(
            title: LocaleKeys.language2.tr()  ,
            icon : Icons.arrow_forward_ios_outlined ,
            islast: false ,
            context: context,
          onTap: (){
            showDialog(
                builder: (_) => ChangeLanguage(), context: context
            );
          }
        ),
        getSettingOption(
            title: LocaleKeys.recalculateBmr.tr()  ,
            icon :  Icons.arrow_forward_ios_outlined ,
            islast:  false,
            context: context,
          onTap: (){
              Navigator.pushNamed(context, recalculateBMR);
          }
        ),
        getSettingOption(
            title: LocaleKeys.darkMode.tr()  ,
            icon :  Switch(onChanged: (bool value) {
              Provider.of<UserDarkTheme>(context , listen: false).changeTheme();
            }, value: Provider.of<UserDarkTheme>(context).isDark) ,
            islast:  false,
            context: context,
        ),
        getSettingOption(
            title: LocaleKeys.logOut.tr()  ,
            icon :  null ,
            islast:  true,
            context: context,
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Constants/localStorage.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Constants/route_id.dart';
import '../../Constants/user_info.dart';
import '../../Constants/user_responsive.dart';
import '../../Data/LocalStorage/db_helper_sharedPrefrences.dart';
import '../../Domain/Auth/auth_cubit.dart';
import '../../Language/locale_keys.g.dart';
import '../Dialogs/sendFeedback.dart';
// ignore: must_be_immutable
class HomeDrawer extends StatefulWidget {
  static String id = "HomeDrawer";
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  HomeDrawer({Key? key , required this.drawerKey}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}
class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20,
              bottom: 20
          ),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(profilePic),
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      LocaleKeys.hello.tr() +"\n${customerData.name}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.grey.shade300,
                  ),
                  getRow((){
                    widget.drawerKey.currentState?.openEndDrawer();
                  } , LocaleKeys.home.tr() , Icons.home),
                  //MyOrders
                  getRow((){
                    Navigator.pushNamed(context, myOrder);
                  } , LocaleKeys.myOrders.tr() , Icons.add_shopping_cart_outlined),
                  //AboutUs
                  getRow((){
                  } , LocaleKeys.aboutUs.tr() , Icons.phone_in_talk_outlined ),
                  //FeedBack
                  getRow((){
                    showDialog(
                      context: context,
                      builder: (_) => sendFeedBackDialog(context)
                    );
                  } , LocaleKeys.sendFeedback.tr() , Icons.feedback),
                  //shareThisApp
                  getRow((){
                  } , LocaleKeys.shareThisApp.tr() , Icons.share),
                  Divider(
                    height: 5,
                    color: Colors.grey.shade300,
                  ),
                  InkWell(
                    onTap: ()async{
                      try{
                        await AuthCubit.get(context).signOut();
                        await CacheHelper.setBool(isSigned, false);
                        Navigator.pushNamedAndRemoveUntil(context, logInPath, (route) => false);
                      // ignore: empty_catches
                      }catch(e){
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              UserResponsive.get(
                              context: context,
                              mobile: 10.sp,
                              tablet: 5.sp
                            )
                          ),
                          child: Text(
                              LocaleKeys.logOut.tr(),
                              style: UserTheme.get(
                                  context: context,
                                  fontSize: UserResponsive.get(
                                      context: context,
                                      mobile: 16.sp,
                                      tablet: 5.sp
                                  ),
                                  fontWight: FontWeight.w600,
                                  colorBright: black,
                                  colorDark: white
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }
  getRow(method , var title , var icon){
    return
      InkWell(
        onTap: method,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                icon,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18
                  )
              ),
            ),
          ],
        ),
      );
  }
}

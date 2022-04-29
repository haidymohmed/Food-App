import 'dart:core';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Constants/user_responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Constants/route_id.dart';
import '../../Domain/ChangeLanguage/language_cubit.dart';
import '../../Domain/DarkTheme.dart';
import '../../Language/locale_keys.g.dart';

class OnBoardingPage extends StatefulWidget {

  static String id = "OnBoardingPage";
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int selectedIndex = 0;
  PageController controller = PageController(viewportFraction: 0.8, keepPage: true, initialPage: 0);
  @override
  Widget build(BuildContext context) {
    debugPrint("******************************** ReBuild ********************************");
    var pages = [
      getPages(LocaleKeys.introTitle1.tr(), LocaleKeys.introContent1.tr(),
          intro1Path, context),
      getPages(LocaleKeys.introTitle2.tr(), LocaleKeys.introContent2.tr(),
          intro2Path, context),
      getPages(LocaleKeys.introTitle3.tr(), LocaleKeys.introContent3.tr(),
          intro3Path, context),
    ];
    return SafeArea(
      child: Directionality(
        textDirection: ChangeLanguageCubit.get(context).isEnglish ?  ui.TextDirection.ltr  : ui.TextDirection.rtl,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width  , MediaQuery.of(context).size.height *0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    debugPrint(context.locale.toString());
                    setState(() {
                      ChangeLanguageCubit.get(context).changeLanguage(context);
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      LocaleKeys.language.tr(),
                      style: UserTheme.get(
                          context: context,
                          fontSize: 15.sp,
                          fontWight: FontWeight.w700,
                          colorBright: black,
                          colorDark: white
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    // Navigator.push(context,  MaterialPageRoute(
                    //     builder: (context) => LogIn()
                    // )
                    //);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      LocaleKeys.skip.tr(),
                      style: UserTheme.get(
                          context: context,
                          fontSize: 15.sp,
                          fontWight: FontWeight.w700,
                          colorBright: green,
                          colorDark: green
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade900 : background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    height: UserResponsive.get(
                      context: context,
                      mobile: UserResponsive.height(context) * 0.65,
                      tablet: UserResponsive.height(context) * 0.55
                    ),
                    child: PageView.builder(
                      controller: controller,
                      allowImplicitScrolling: true,
                      itemCount: 3,
                      // itemCount: pages.length,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      onPageChanged: (v) {
                        setState(() {
                          setState(() {
                            selectedIndex = v;
                          });
                        });
                      },
                      itemBuilder: (_, index) {
                        return pages[index];
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: pages.length,
                    effect: WormEffect(
                        dotHeight: 8.sp,
                        dotWidth: 8.sp,
                        activeDotColor: green
                      // strokeWidth: 5,
                    ),
                  ),
                  SizedBox(height: 50.sp),
                  InkWell(
                    onTap: () async{
                      debugPrint(selectedIndex.toString());
                      if (selectedIndex == 2) {
                        Navigator.pushNamed(context,logInPath);
                      } else{
                        controller.jumpToPage(selectedIndex + 1);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5.sp),
                      width: UserResponsive.get(
                          context: context,
                          mobile: 40.sp,
                          tablet: 35.sp
                      ),
                      height:UserResponsive.get(
                          context: context,
                          mobile: 40.sp,
                          tablet: 35.sp
                      ),
                      decoration: BoxDecoration(
                          color : green,
                          borderRadius: BorderRadius.circular(5.sp)
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 25.sp,
                        color: white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      )
    );
  }

  getPages(title, content, image, context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Image.asset(image),
            ),
            Expanded(
              flex: 1,
                child: Text(
                  title,
                  style: UserTheme.get(
                      context: context,
                      fontSize: UserResponsive.get(
                        context: context,
                        mobile: 20.sp,
                        tablet: 18.sp
                      ),
                      fontWight: FontWeight.w700,
                      colorBright: black,
                      colorDark: white
                  ),
                ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: UserTheme.get(
                      context: context,
                      fontSize: UserResponsive.get(
                          context: context,
                          mobile: 16.sp,
                          tablet: 13.sp
                      ),
                      fontWight: FontWeight.w600,
                      colorBright: black,
                      colorDark: Colors.grey.shade500
                  ),
                ),
            ),
            const Spacer(),
          ],
        )
    );
  }
}

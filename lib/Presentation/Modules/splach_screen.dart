import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/app_route.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Constants/user_info.dart';
import '../../Data/LocalStorage/db_helper_sharedPrefrences.dart';
import '../../Data/Models/User.dart';
import '../../Domain/DarkTheme.dart';
// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  late Widget nextScreen;
  SplashScreen({Key? key,  required this.nextScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    customerData = UserDetails(
      name  : CacheHelper.getString("userName"),
      id  : CacheHelper.getString("userId"),
      pass  : CacheHelper.getString("userPassword"),
      email  : CacheHelper.getString("userEmail"),
      phone  : CacheHelper.getString("userPhone"),
    );
    return Scaffold(
      backgroundColor: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade900 : background,
          body: ModalProgressHUD(
            opacity: 0.36,
            inAsyncCall: true,
            progressIndicator: SpinKitFadingCircle(
              color: green,
              size: 50.sp,
            ),
            offset: Offset.fromDirection(50 , 50),
            child: AnimatedSplashScreen(
                splashTransition: SplashTransition.fadeTransition,
                duration: 200,
                nextScreen:  NextSplash(nextScreen: nextScreen) ,
                splash: Container(
                  alignment: Alignment.center,
                  width: 100.sp,
                  height: 100.sp,
                  color: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade900 : background,
                  child: LayoutBuilder(
                    builder: (context , constraints) => SizedBox(
                      width: constraints.maxWidth /2 ,
                      height: constraints.maxHeight /1.5 ,
                      child: SvgPicture.asset(
                        logoPath,
                        color: green,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
            ),
          ),
        );
  }
}

// ignore: must_be_immutable
class NextSplash extends StatelessWidget{
  late Widget nextScreen;
  NextSplash({Key? key,  required this.nextScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
          body: AnimatedSplashScreen(
            nextScreen: AppRoute.getNextScreen(),
            splashTransition: SplashTransition.fadeTransition,
            duration: 500,
            splash: Container(
               width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    color: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade900 : background,
                    image: const DecorationImage(
                        image: AssetImage(
                            splashBackPath
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.5
                    )
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) => LayoutBuilder(
                    builder: (context , constraints) => Container(
                      margin: EdgeInsets.only(top: constraints.maxHeight / 4),
                      width: constraints.maxWidth /2,
                      height: constraints.maxHeight /1.5 ,
                      child: SvgPicture.asset(
                        logoPath,
                        color: green,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                )
            ),
          ),
        );
  }
}

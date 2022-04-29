import 'package:flutter/material.dart';
import 'package:restaurant_app/Presentation/Modules/best_seller.dart';
import 'Constants/localStorage.dart';
import 'Constants/route_id.dart';
import 'Data/LocalStorage/db_helper_sharedPrefrences.dart';
import 'Presentation/Modules/account_info.dart';
import 'Presentation/Modules/address_information.dart';
import 'Presentation/Modules/change_email.dart';
import 'Presentation/Modules/change_password.dart';
import 'Presentation/Modules/forgetPassword.dart';
import 'Presentation/Modules/home.dart';
import 'Presentation/Modules/introduction_screen.dart';
import 'Presentation/Modules/log_in.dart';
import 'Presentation/Modules/my_orders.dart';
import 'Presentation/Modules/new_arrivale.dart';
import 'Presentation/Modules/phone_number.dart';
import 'Presentation/Modules/re_calculate_bmr.dart';
import 'Presentation/Modules/sendLoginLink.dart';
import 'Presentation/Modules/sign_up.dart';
import 'Presentation/Modules/splach_screen.dart';

class AppRoute{
  static Route onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case introductionPath:
        return navigateTo(SplashScreen(nextScreen: const OnBoardingPage(),));
      case singUpPath:
        return navigateTo(const SignUp());
      case logInPath:
        return navigateTo(const LogIn());
      case homePath:
        return navigateTo(const Home());
      case viewProducts :
        return navigateTo(const ViewAllProducts());
      case sendEmailLinkPath:
        return navigateTo(SendLoginLink());
      case forgetPassPath:
        return navigateTo(const ForgetPassword());
      case accountInfoPath :
        return navigateTo(const AccountInfo());
      case addressInfoPath :
        return navigateTo(AddressInfo());
      case newArrival :
        return navigateTo(const NewArrival());
      case recalculateBMR :
        return navigateTo(const RecalculateBMR());
      case phoneNumberPath :
        return navigateTo(const PhoneNumber());
      case changePass :
        return navigateTo(const ChangePassword());
      case changeEmail :
        return navigateTo(const ChangeEmail());
      case myOrder:
        return navigateTo(const MyOrders());
      default:
        return navigateTo(SplashScreen(nextScreen: const OnBoardingPage()));
    }
  }
  static navigateTo(destination){
    return MaterialPageRoute(builder: (context) => destination);
  }
  static getNextScreen(){
    var first = CacheHelper.getBool(firstTime);
    var signed = CacheHelper.getBool(isSigned);
    if(first == false){
      return const OnBoardingPage();
    }
    else{
      if(signed == false){
        return const LogIn();
      }
      else{
        return const Home();
      }
    }
  }
}
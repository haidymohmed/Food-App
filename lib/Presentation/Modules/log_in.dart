import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app/Constants/user_responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Constants/localStorage.dart';
import '../../Constants/route_id.dart';
import '../../Constants/user_info.dart';
import '../../Data/LocalStorage/db_helper_sharedPrefrences.dart';
import '../../Data/Models/User.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/Auth/auth_cubit.dart';
import '../../Language/locale_keys.g.dart';
import '../Widgets/customer_button.dart';
import '../Widgets/customer_textField.dart';
import '../Widgets/title_text_field.dart';
class LogIn extends StatefulWidget {
  static String id = "LogIn";
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}
class _LogInState extends State<LogIn> {
  bool inAsyncCall = false ;
  late String email ="", password ="";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var list = [
    GetIcon(color: Colors.red, icon: googleIcon),
    GetIcon(color: Colors.blue.shade500, icon: facebookIcon),
    GetIcon(color: Colors.black, icon: appleIcon),
    GetIcon(color: green, icon: phoneIcon),
  ];
  
  bool? rememberMe = true;
  @override
  Widget build(BuildContext context) {
    CacheHelper.setBool(firstTime , true);
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<AsyncCall>(context).inAsyncCall,
          progressIndicator: SpinKitFadingCircle(
            color: green,
            size: 50,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.sp,),
                SvgPicture.asset(
                  logoPath,
                  width: UserResponsive.get(
                    context: context,
                    mobile: MediaQuery.of(context).size.width * 0.4,
                    tablet: MediaQuery.of(context).size.width * 0.25
                  ),
                  height: UserResponsive.get(
                      context: context,
                      mobile: MediaQuery.of(context).size.width * 0.4,
                      tablet: MediaQuery.of(context).size.width * 0.25
                  ),
                  fit: BoxFit.cover,
                  color: green,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    LocaleKeys.logInScreenTitle.tr(),
                    textAlign: TextAlign.center,
                    style: UserTheme.get(
                        context: context,
                        fontWight: FontWeight.w500,
                        fontSize: UserResponsive.get(
                            context: context,
                            mobile: 16.sp,
                            tablet: 12.sp
                        ),
                        colorBright: Colors.grey.shade900,
                        colorDark: Colors.white
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      getAlignText(LocaleKeys.email.tr() , context),
                      CustomerTextField(
                        hint: LocaleKeys.enterEmail.tr(),
                        reedOnly: false,
                        scure: false,
                        suffixIcon: false,
                        peffixIconData: Icons.email,
                        isPhone: false,
                        onSaved: (v){
                          if(formKey.currentState?.validate() == true){
                            email = v.toString();
                          }
                        },
                        validator: (v){
                          if(v.toString().isNotEmpty){
                            setState(() {
                              inAsyncCall = true ;
                            });
                            if(v.toString().endsWith("@gmail.com")){
                            }
                            else {
                              return "Invalid Email";
                            }
                          }
                          else {
                            return "Required *" ;
                          }
                        },
                      ),
                      getAlignText(LocaleKeys.password.tr() , context),
                      CustomerTextField(
                        hint: LocaleKeys.enterPass.tr(),
                        reedOnly: false,
                        isPhone: false,
                        scure: true,
                        suffixIcon: true,
                        peffixIconData: Icons.lock,
                        suffixIconData: Icons.remove_red_eye_rounded,
                        onSaved: (v){
                          if(formKey.currentState?.validate() == true){
                            password = v.toString();
                          }
                        },
                        validator: (v){
                          if(v.toString().isNotEmpty){
                            if(v.toString().length > 8){
                            }
                            else {
                              return "Invalid Password";
                            }
                          }
                          else {
                            return "Required *" ;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: UserResponsive.get(
                          context: context,
                          mobile: 12.sp,
                          tablet: UserResponsive.width(context) * 0.2
                      ),
                    vertical: UserResponsive.get(
                        context: context,
                        mobile: 0.1,
                        tablet: 5.sp
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.sp),
                        child: Transform.scale(
                          scale: UserResponsive.get(
                              context: context,
                              mobile: 1.0,
                              tablet: 1.5
                          ),
                          child: Checkbox(
                            value: rememberMe,
                            onChanged: (v) {
                              setState(() {
                                rememberMe = v;
                              });
                            },
                            checkColor: Colors.white,
                            splashRadius: 30.sp,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: BorderSide(width: 1.sp, color: grey),
                            activeColor: green,
                          ),
                        ),
                      ),
                      Text(
                        LocaleKeys.rememberMe.tr(),
                        style: UserTheme.get(
                            context: context,
                            fontWight: FontWeight.w500,
                            fontSize: UserResponsive.get(
                              context: context,
                              mobile: 13.sp,
                              tablet: 10.sp
                            ),
                            colorBright:  Colors.grey.shade900,
                            colorDark : Colors.grey.shade300
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, forgetPassPath);
                        },
                        child: Text(
                          LocaleKeys.forgetPass.tr(),
                          style: UserTheme.get(
                              context: context,
                              fontWight: FontWeight.w500,
                              fontSize: UserResponsive.get(
                                  context: context,
                                  mobile: 13.sp,
                                  tablet: 10.sp
                              ),
                              colorBright:  green,
                              colorDark : green
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                UserButton(
                  title: LocaleKeys.logIn.tr(),
                  method: () async{
                    if(formKey.currentState?.validate() == true){
                      Provider.of<AsyncCall>(context,listen: false).changeAsyncCall(true);
                      try{
                        formKey.currentState?.save();
                        customerData =  UserDetails(email:  email , pass:  password, id: '', phone: '', name: '');
                        await AuthCubit.get(context).logInWithEmail();
                        await CacheHelper.setUserInfo(customerData);
                        Navigator.pushNamed(context, homePath);
                      }catch(e){
                        debugPrint(e.toString());
                      }
                    }
                    Provider.of<AsyncCall>(context,listen: false).changeAsyncCall(false);
                  },
                  color: green,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: UserResponsive.get(
                          context: context,
                          mobile: 12.sp,
                          tablet: UserResponsive.width(context) * 0.2
                      ),
                      vertical: 5.sp
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.doNotHaveAnAcc.tr(),
                        style: UserTheme.get(
                            context: context,
                            fontWight: FontWeight.w500,
                            fontSize: UserResponsive.get(
                                context: context,
                                mobile: 15.sp,
                                tablet: 10.sp
                            ),
                            colorBright:  black,
                            colorDark : Colors.grey.shade300
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, singUpPath);
                        },
                        child: Text(
                          LocaleKeys.signUp.tr(),
                          style: UserTheme.get(
                              context: context,
                              fontWight: FontWeight.w500,
                              fontSize: UserResponsive.get(
                                  context: context,
                                  mobile: 15.sp,
                                  tablet: 10.sp
                              ),
                              colorBright:  green,
                              colorDark : green
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: UserResponsive.get(
                      context: context,
                      mobile: 15.sp,
                      tablet: UserResponsive.width(context) * 0.2
                    )
                  ),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Divider(
                            color: grey,
                            height: 36,
                            thickness: 1.sp,
                          )),
                    ),
                    Text(
                      LocaleKeys.or.tr(),
                      style: UserTheme.get(
                          context: context,
                          fontSize: UserResponsive.get(
                              context: context,
                              mobile: 15.sp,
                              tablet: 12.sp
                          ),
                          fontWight: FontWeight.w700,
                          colorBright: Colors.grey.shade800,
                          colorDark: Colors.grey.shade400
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Divider(
                            color: grey,
                            height: 36,
                            thickness: 1.sp,
                          )),
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.sp
                  ),
                  width: UserResponsive.width(context),
                  height: UserResponsive.get(
                    context: context,
                    mobile: 80.sp,
                    tablet: 40.sp
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 4; i++) getIconsContainer(list[i] , ()async{
                        Provider.of<AsyncCall>(context,listen: false).changeAsyncCall(true);
                        try{
                          if(i == 0) {
                            await AuthCubit.get(context).signInWithGoogle();
                            Navigator.pushNamed(context, homePath);
                          } else if(i == 1) {
                            await AuthCubit.get(context).signInWithFaceBook();
                          } else if(i == 2) {
                            await AuthCubit.get(context).signInWithApple();
                          } else if(i == 3) {
                            Navigator.pushNamed(context, phoneNumberPath);
                          }
                          // ignore: empty_catches
                          }catch(e){
                        }
                        Provider.of<AsyncCall>(context,listen: false).changeAsyncCall(false);
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 25.sp),
              ],
            ),
          ),
        )
      ),
    );
  }

  getIconsContainer(GetIcon item , method) {
    return InkWell(
      onTap: method,
      child: Container(
        padding: EdgeInsets.all(
            UserResponsive.get(
                context: context,
                mobile: 10.sp,
                tablet: 5.sp
            )
        ),
        margin: const EdgeInsets.all(10),
        width: UserResponsive.get(
            context: context,
            mobile: 40.sp,
            tablet: 30.sp
        ),
        height: UserResponsive.get(
            context: context,
            mobile: 40.sp,
            tablet: 30.sp
        ),
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return SvgPicture.asset(
            item.icon,
          );
        }),
      ),
    );
  }
}

class GetIcon {
  // ignore: prefer_typing_uninitialized_variables
  var color, icon;
  GetIcon({required this.icon, required this.color});
}

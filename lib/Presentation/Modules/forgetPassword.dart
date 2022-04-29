import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Constants/user_responsive.dart';
import 'package:restaurant_app/Presentation/Modules/sendLoginLink.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/DarkTheme.dart';
import '../../Language/locale_keys.g.dart';
import '../Widgets/customer_button.dart';
import '../Widgets/customer_textField.dart';

class ForgetPassword extends StatefulWidget {
  static String id = "ForgetPassword";
  const ForgetPassword({Key? key}) : super(key: key);
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with TickerProviderStateMixin  {
  late String email , phoneNumber;
  int index = 0;
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall : Provider.of<AsyncCall>(context).inAsyncCall,
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height ,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.sp,),
                  Container(
                    width: 60.sp,
                    height: 60.sp,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(42.sp),
                      border: Border.all(color: Provider.of<UserDarkTheme>(context).isDark?  white :Colors.black , width: 2)
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: 30.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15.sp,
                      bottom: 10.sp
                    ),
                    child: Text(
                      LocaleKeys.troubleLoggingIn.tr(),
                      style: UserTheme.get(
                        fontSize: UserResponsive.get(
                          context: context,
                          mobile: 15.sp,
                          tablet: 13.sp
                        ),
                        fontWight: FontWeight.w700,
                        context: context,
                        colorBright: black,
                        colorDark: white
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UserResponsive.get(
                          context: context,
                          mobile: 20.sp,
                          tablet: UserResponsive.width(context) * 0.2
                      )
                    ),
                    child: Text(
                      LocaleKeys.forgetPassHint.tr(),
                      textAlign: TextAlign.center,
                      style: UserTheme.get(
                          fontSize: UserResponsive.get(
                              context: context,
                              mobile: 13.sp,
                              tablet: 10.sp
                          ),
                          fontWight: FontWeight.w500,
                          context: context,
                          colorBright: black,
                          colorDark: white
                      ),
                    ),
                  ),
                  Container(
                    margin : EdgeInsets.symmetric(
                        horizontal: 20.sp,
                      vertical: 10.sp
                    ),
                    child: DefaultTabController(
                        length: 2, // length of tabs
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TabBar(
                              labelColor: Provider.of<UserDarkTheme>(context).isDark?  white :Colors.black,
                              unselectedLabelColor: Colors.grey.shade600,
                              indicatorColor: Provider.of<UserDarkTheme>(context).isDark?  white :Colors.black,
                              indicatorWeight: 3,
                              tabs: [
                                Text(
                                  LocaleKeys.userName.tr(),
                                  style: UserTheme.get(
                                      fontSize: UserResponsive.get(
                                          context: context,
                                          mobile: 16.sp,
                                          tablet: 14.sp
                                      ),
                                      fontWight: FontWeight.w700,
                                      context: context,
                                      colorBright: null,
                                      colorDark: null
                                  ),
                                ),
                                Text(
                                  LocaleKeys.phone.tr(),
                                  style: UserTheme.get(
                                      fontSize: UserResponsive.get(
                                          context: context,
                                          mobile: 16.sp,
                                          tablet: 14.sp
                                      ),
                                      fontWight: FontWeight.w700,
                                      context: context,
                                      colorBright: null,
                                      colorDark: null
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                height: UserResponsive.get(
                                    context: context,
                                    mobile: 150.sp,
                                    tablet: 40.sp
                                ),
                                padding: EdgeInsets.only(top: 10.sp , right: 0, left: 0),
                                child: TabBarView(
                                    children: <Widget>[
                                      Form(
                                        key: formKey1,
                                        child: Column(
                                          children: [
                                            Center(
                                              child: CustomerTextField(
                                                hint: LocaleKeys.enterYourName.tr(),
                                                reedOnly: false,
                                                isPhone: false,
                                                scure: false,
                                                suffixIcon: true,
                                                validator: (v){
                                                  if(v.toString().endsWith("@gmail.com")){
                                                  }
                                                  else{
                                                    return "Invalid Email";
                                                  }
                                                },
                                                onSaved: (v){
                                                  setState(() {
                                                    email = v.toString();
                                                  });
                                                },
                                              ),
                                            ),
                                            UserButton(
                                                title : LocaleKeys.next.tr(),
                                                color: green,
                                                method: (){
                                                  if(formKey1.currentState?.validate() == true){
                                                    formKey1.currentState?.save();
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => SendLoginLink(
                                                          email: email,
                                                        )
                                                      )
                                                    );
                                                  }
                                                }
                                            ),
                                          ],
                                        ),
                                      ),
                                      Form(
                                        key: formKey2,
                                        child: Column(
                                          children: [
                                            Center(
                                              child: CustomerTextField(
                                                hint: LocaleKeys.enterYourPhone.tr(),
                                                reedOnly: false,
                                                isPhone: true,
                                                scure: false,
                                                suffixIcon: true,
                                                validator: (v){
                                                  if(v.toString().isEmpty){
                                                    return 'Required ';
                                                  }
                                                  else if(v.toString().length < 10){
                                                    return "Invalid Phone Number";
                                                  }
                                                },
                                                onSaved: (v){
                                                  setState(() {
                                                    phoneNumber = v.toString();
                                                    }
                                                  );
                                                },
                                              ),
                                            ),
                                            UserButton(
                                                title: LocaleKeys.next.tr(),
                                                color: green,
                                                method: (){
                                                  if(formKey2.currentState?.validate() == true){
                                                    formKey2.currentState?.save();
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => SendLoginLink(
                                                          phoneNumber: phoneNumber,
                                                          code: "+02",
                                                        )
                                                      )
                                                    );
                                                  }
                                                }
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]
                                ),
                            )
                          ]
                        )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    width: MediaQuery.of(context).size.width,
                    height: 50.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                          },
                          child: Text(
                            LocaleKeys.needMoreHelp.tr(),
                            style: UserTheme.get(
                                context: context,
                                fontSize: UserResponsive.get(
                                    context: context,
                                    mobile: 15.sp,
                                    tablet: 12.sp
                                ),
                                fontWight: FontWeight.w700,
                                colorBright: green,
                                colorDark: green
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

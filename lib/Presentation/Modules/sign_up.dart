import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Constants/route_id.dart';
import '../../Constants/user_info.dart';
import '../../Constants/user_responsive.dart';
import '../../Data/LocalStorage/db_helper_sharedPrefrences.dart';
import '../../Data/Models/User.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/Auth/auth_cubit.dart';
import '../../Domain/ChangeLanguage/language_cubit.dart';
import '../../Language/locale_keys.g.dart';
import '../Widgets/customer_button.dart';
import '../Widgets/customer_textField.dart';
import '../Widgets/title_text_field.dart';
class SignUp extends StatefulWidget {
  static String id = "SignUp";
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool inAsyncCall = false ;
  late String email, password , phone , name ;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool? rememberMe = true;
  @override
  Widget build(BuildContext context) {
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
                      LocaleKeys.createNewAccount.tr(),
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
                        //Name
                        getAlignText(LocaleKeys.name.tr() , context),
                        CustomerTextField(
                          hint: LocaleKeys.enterYourName.tr(),
                          scure: false,
                          reedOnly: false,
                          suffixIcon: false,
                          isPhone: false,
                          peffixIconData: Icons.person,
                          onSaved: (v){
                            if(formKey.currentState?.validate() == true){
                              setState(() {
                                name = v.toString();
                              });
                            }
                          },
                          validator: (v){
                            if(v.toString().isNotEmpty){
                            }
                            else {
                              return "Required *" ;
                            }
                          },
                        ),
                        //Email
                        getAlignText("Email" , context),
                        CustomerTextField(
                          hint: 'Enter your Email',
                          reedOnly: false,
                          scure: false,
                          suffixIcon: false,
                          peffixIconData: Icons.email,
                          isPhone: false,
                          onSaved: (v){
                            if(formKey.currentState?.validate() == true){
                              setState(() {
                                email = v.toString();
                              });
                            }
                          },
                          validator: (v){
                            if(v.toString().isNotEmpty){
                              setState(() {
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
                        //phone
                        getAlignText("Phone" , context),
                        CustomerTextField(
                          reedOnly: false,
                          hint: 'Enter your Phone',
                          scure: false,
                          suffixIcon: false,
                          isPhone: true,
                          country: "Eg",
                          peffixIconData: Icons.phone,
                          onSaved: (v){
                            if(formKey.currentState?.validate() == true){
                              setState(() {
                                phone = v.toString();
                              });
                            }
                          },
                          validator: (v){
                            if(v.toString().isNotEmpty){
                            }
                            else {
                              return "Required *" ;
                            }
                          },
                        ),
                        //Password
                        Container(
                          margin: EdgeInsets.only(
                              top: 8.sp,
                              left: UserResponsive.get(
                                context: context,
                                mobile: 14.sp,
                                tablet: UserResponsive.width(context) *0.2
                              ),
                              right: UserResponsive.get(
                                  context: context,
                                  mobile: 14.sp,
                                  tablet: UserResponsive.width(context) *0.2
                              )
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: ChangeLanguageCubit.get(context).isEnglish ?  Alignment.centerLeft : Alignment.centerRight,
                                child: Text(
                                  "Password",
                                  style: UserTheme.get(
                                      context: context,
                                      fontSize:  UserResponsive.get(
                                        context: context,
                                        mobile: 14.sp,
                                        tablet: 12.sp
                                      ),
                                      fontWight: FontWeight.w600,
                                      colorBright: black,
                                      colorDark: white
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: "password must be 8 characters \n,sample like @&* and numbers",
                                child: const Icon(
                                  Icons.help,
                                ),
                                height: 35.sp,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    color: Colors.black.withOpacity(0.9)
                                ),
                                textStyle: UserTheme.get(
                                    context: context,
                                    fontSize: UserResponsive.get(
                                        context: context,
                                        mobile: 10.sp,
                                        tablet: 10.sp
                                    ),
                                    fontWight: FontWeight.w700,
                                    colorBright: black,
                                    colorDark: white
                                ),
                                waitDuration: const Duration(
                                  minutes: 1,
                                ),
                                preferBelow: false,
                                triggerMode: TooltipTriggerMode.tap,
                              )
                            ],
                          ),
                        ),
                        CustomerTextField(
                          hint: "Enter your Password",
                          reedOnly: false,
                          scure: true,
                          suffixIcon: true,
                          isPhone: false,
                          peffixIconData: Icons.lock,
                          suffixIconData: Icons.remove_red_eye_rounded,
                          onSaved: (v){
                            if(formKey.currentState?.validate() == true){
                              setState(() {
                                password = v.toString();
                              });
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
                  SizedBox(height: 20.sp),
                  UserButton(
                    title: 'Sign Up',
                    method: () async{
                      Provider.of<AsyncCall>(context, listen: false).changeAsyncCall(true);
                      if(formKey.currentState?.validate() == true){
                          formKey.currentState?.save();
                          try{
                            setState(() {
                              customerData =  UserDetails(email: email , pass: password , phone:  phone , name:  name, id: '');
                            });
                            await AuthCubit.get(context).createAccount();
                            await CacheHelper.setUserInfo(customerData);
                            Navigator.pushNamed(context, homePath);
                          }catch(e){
                            debugPrint("Error: " + e.toString());
                          }
                      }
                      Provider.of<AsyncCall>(context, listen: false).changeAsyncCall(false);
                    },
                    color: green
                  ),
                  
                  SizedBox(height: 10.sp,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have An account ? ",
                          style: UserTheme.get(
                              context: context,
                              fontWight: FontWeight.w500,
                              fontSize: UserResponsive.get(
                                  context: context,
                                  mobile: 15.sp,
                                  tablet: 12.sp
                              ),
                              colorBright:  black,
                              colorDark : Colors.grey.shade300
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, logInPath);
                          },
                          child: Text(
                            "Log In",
                            style: UserTheme.get(
                                context: context,
                                fontWight: FontWeight.w500,
                                fontSize: UserResponsive.get(
                                    context: context,
                                    mobile: 15.sp,
                                    tablet: 12.sp
                                ),
                                colorBright:  green,
                                colorDark : green
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.sp,),
                ],
              ),
            ),
          )
      ),
    );
  }
}

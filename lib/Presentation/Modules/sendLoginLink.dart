import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Domain/Auth/auth_cubit.dart';
import 'package:restaurant_app/Presentation/Modules/verify_phone.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Constants/user_responsive.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/DarkTheme.dart';
import '../../Language/locale_keys.g.dart';
import '../Widgets/customer_button.dart';

// ignore: must_be_immutable
class SendLoginLink extends StatefulWidget {

  static String id = "SendLoginLink";
  String? email , phoneNumber , code;
  SendLoginLink({Key? key , this.email , this.phoneNumber , this.code}) : super(key: key);

  @override
  _SendLoginLinkState createState() => _SendLoginLinkState();
}

enum SendLink  {sendEmail ,sendSMS }
class _SendLoginLinkState extends State<SendLoginLink> {
  var value = SendLink.sendEmail;
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
                  CircleAvatar(
                    radius: 29.sp,
                    backgroundImage: const AssetImage(profilePic),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 15.sp,
                        bottom: 10.sp
                    ),
                    child: Text(
                      "Haidy Mohmed",
                      style:  UserTheme.get(
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
                      LocaleKeys.sendEmilHint.tr(),
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
                    margin: EdgeInsets.symmetric(
                        vertical: UserResponsive.get(
                            context: context,
                            mobile: 22.sp,
                            tablet: 15.sp
                        ),
                      horizontal: UserResponsive.get(
                          context: context,
                          mobile: 20.sp,
                          tablet: UserResponsive.width(context) * 0.2
                      )
                    ),
                    padding: EdgeInsets.all(5.sp),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: grey),
                      color: Provider.of<UserDarkTheme>(context).isDark?  Colors.grey.shade700 : white,
                      borderRadius: BorderRadius.circular(10.sp)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RadioListTile(
                          title: Text(
                            LocaleKeys.sendAnEmail.tr(),
                            style: UserTheme.get(
                                context: context,
                                fontSize: UserResponsive.get(
                                    context: context,
                                    mobile: 15.sp,
                                    tablet: 10.sp
                                ),
                                fontWight: FontWeight.w700,
                                colorBright: black,
                                colorDark: white
                            )
                          ),
                          subtitle: Text(
                            "ha********01@gmail.com",
                            style: UserTheme.get(
                              context: context,
                              fontSize: UserResponsive.get(
                                  context: context,
                                  mobile: 13.sp,
                                  tablet: 9.sp
                              ),
                              fontWight: FontWeight.w600,
                              colorBright: grey,
                              colorDark: Colors.grey.shade400
                          )
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          groupValue: value,
                          activeColor: green,
                          onChanged: (SendLink? v) {
                            setState(() {
                              value = v!;
                            });
                          },
                          value: SendLink.sendEmail,
                        ),
                        SizedBox(height: 5.sp,),
                        RadioListTile(
                          title: Text(
                            LocaleKeys.sendSmsMessage.tr(),
                            style: UserTheme.get(
                                context: context,
                                fontSize: UserResponsive.get(
                                    context: context,
                                    mobile: 15.sp,
                                    tablet: 10.sp
                                ),
                                fontWight: FontWeight.w700,
                                colorBright: black,
                                colorDark: white
                            )
                          ),
                          subtitle: Text(
                            "********325",
                            style: UserTheme.get(
                                context: context,
                                fontSize: UserResponsive.get(
                                    context: context,
                                    mobile: 13.sp,
                                    tablet: 9.sp
                                ),
                                fontWight: FontWeight.w600,
                                colorBright: grey,
                                colorDark: Colors.grey.shade400
                            )
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: SendLink.sendSMS,
                          groupValue: value,
                          activeColor: green,
                          onChanged: (SendLink? v) {
                            setState(() {
                              value = v!;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.sp,
                    ),
                    child: UserButton(
                        title: LocaleKeys.sendLoginLinkButton.tr(),
                        color: green,
                        method: () async{
                          if(widget.phoneNumber == null && widget.email != null){
                            AuthCubit.get(context).forgotPassword(widget.email);
                          }
                          if(widget.phoneNumber != null && widget.email == null){
                            await AuthCubit.get(context).signInWithPhone( widget.code! + widget.phoneNumber.toString());
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> VerifyPhone(phone: widget.phoneNumber.toString())));
                          }
                        }
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    width: MediaQuery.of(context).size.width * 0.5,
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
                                    tablet: 11.sp
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

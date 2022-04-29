import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Language/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../Constants/colors.dart';
import '../../Constants/route_id.dart';
import '../../Constants/user_responsive.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/Auth/auth_cubit.dart';
import '../../Domain/DarkTheme.dart';
import '../Widgets/change_textfield.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/customer_button.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String newEmail , oldPass , newPass , confirmPass;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: Provider.of<AsyncCall>(context).inAsyncCall,
          child: Scaffold(
            backgroundColor: Provider.of<UserDarkTheme>(context).isDark? null  : background,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  getAppBar(
                      context: context,
                      perffix: InkWell(
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
                      suffix: Container(width: 25.sp,),
                      title: LocaleKeys.changeEmail.tr()
                  ),
                  SizedBox(height: 30.sp,),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        getChangeTextField(
                            title: LocaleKeys.newEmail.tr(),
                          onSave: (v){
                              setState(() {
                                newEmail = v.toString();
                              });
                          }, context: context
                        ),
                        getChangeTextField(
                            context: context,
                            title: LocaleKeys.currentPassword.tr(),
                            onSave: (v){
                              setState(() {
                                oldPass = v.toString();
                              });
                            },
                            onValidate : (v){
                              if(v.toString().length > 8){

                              }else{
                                return "Less than 8";
                              }
                            }
                        ),
                        getChangeTextField(
                            context: context,
                            title: LocaleKeys.newPassword.tr(),
                            onSave: (v){
                              setState(() {
                                newPass = v.toString();
                              });
                            },
                            onValidate : (v){
                              if(v.toString().length > 8){

                              }else{
                                return "Less than 8";
                              }
                            }
                        ),
                        getChangeTextField(
                            context: context,
                            title: LocaleKeys.confirmNewPassword.tr(),

                            onValidate : (v){
                              if(v.toString().length > 8){

                              }else{
                                return "Less than 8";
                              }
                            },
                            onSave: (v){
                              setState(() {
                                confirmPass = v.toString();
                              });
                            }
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.sp,),
                  UserButton(
                      title: LocaleKeys.submit.tr(),
                      color: green,
                      method: ()async {
                          Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(true);
                          formKey.currentState?.save();
                          if(newPass == confirmPass){
                            if(formKey.currentState?.validate() == true){
                              formKey.currentState?.save();
                              try{
                                await AuthCubit.get(context).changeEmail(oldPass: oldPass, newEmail: newEmail, newPass: confirmPass );
                                Navigator.pushNamedAndRemoveUntil(context, homePath, (route) => false);
                              }catch(e){
                                debugPrint(e.toString());
                              }
                            }
                          }
                          Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(false);
                        }

                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

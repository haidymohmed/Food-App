import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../Constants/colors.dart';
import '../../Constants/route_id.dart';
import '../../Constants/user_responsive.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/Auth/auth_cubit.dart';
import '../../Domain/DarkTheme.dart';
import '../../Language/locale_keys.g.dart';
import '../Widgets/change_textfield.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/customer_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String  oldPass , newPass , confirmPass;
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
                      title: LocaleKeys.changePassword.tr(),
                  ),
                  SizedBox(height: 20.sp,),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        getChangeTextField(
                            context: context,
                            title: LocaleKeys.currentPassword.tr(),
                            onSave: (v){
                              setState(() {
                                oldPass = v.toString();
                              });
                            }
                        ),
                        getChangeTextField(
                            context: context,
                            title: LocaleKeys.newPassword.tr(),
                            contraller: controller,
                            onSave: (v){
                              setState(() {
                                newPass = v.toString();
                              });
                            }
                        ),
                        getChangeTextField(
                            context: context,
                            title: LocaleKeys.confirmNewPassword.tr(),
                            onValidate: (v){
                              if(v.toString() == controller.text){}
                              else {
                                return "Password doesnot match !";
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
                        if(formKey.currentState?.validate() == true){
                          formKey.currentState?.save();
                          try{
                            await AuthCubit.get(context).changePassword(oldPass: oldPass,newPass: confirmPass);
                            Navigator.pushNamedAndRemoveUntil(context, homePath, (route) => false);
                          }catch(e){
                            debugPrint(e.toString());
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

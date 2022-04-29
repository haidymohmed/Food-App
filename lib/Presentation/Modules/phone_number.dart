import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Domain/Auth/auth_state.dart';
import 'package:restaurant_app/Presentation/Dialogs/AppToast.dart';
import 'package:restaurant_app/Presentation/Modules/verify_phone.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/Auth/auth_cubit.dart';
import '../Widgets/customer_button.dart';
import '../Widgets/customer_textField.dart';
import 'package:sizer/sizer.dart';
import '../Widgets/title_text_field.dart';

class PhoneNumber extends StatefulWidget {

  static String id = "PhoneNumber";
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {

  bool inAsyncCall = false ;
  late String  phone  ;
  // ignore: prefer_typing_uninitialized_variables
  var country;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool? rememberMe = true;
  @override
  Widget build(BuildContext context) {
    Provider.of<AsyncCall>(context).inAsyncCall = false;
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton(color: Colors.black, ),
                  ),
                  SizedBox(height: 7.sp,),
                  SvgPicture.asset(
                    logoPath,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.3,
                    fit: BoxFit.cover,
                    color: green,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Continue With Phone Number",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        //Country
                        getAlignText("Country" , context),
                        CustomerTextField(
                          hint: "Egypt",
                          scure: false,
                          suffixIcon: false,
                          isPhone: true,
                          country: "Eg",
                          reedOnly: true,
                          peffixIconData: Icons.phone,
                          onSaved: (v){
                            if(formKey.currentState?.validate() == true){
                              country = v;
                            }
                          },
                          validator: (v){
                          },
                        ),
                        //phone
                        getAlignText("Phone" , context),
                        CustomerTextField(
                          hint: 'Number',
                          reedOnly: false,
                          scure: false,
                          suffixIcon: false,
                          isPhone: false,
                          peffixIconData: Icons.phone,
                          onSaved: (v){
                            if(formKey.currentState?.validate() == true){
                              phone = v.toString();
                            }
                          },
                          validator: (v){
                            if(v.toString().isNotEmpty){
                              setState(() {
                              });
                              if(v.toString().length == 11){
                              }
                              else {
                                return "Invalid Number";
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
                  SizedBox(height: 3.sp,),
                  BlocListener<AuthCubit ,AuthStates>(
                    listener: (context, state) {
                      if(state is PhoneSuccess){
                        showToastError(
                          msg: "Code is sent to ${state.phoneNumber}",
                          state : ToastedStates.SUCCESS,
                        );
                      }
                      else if (state is PhoneFailed){
                        showToastError(
                          msg: "Invalid Number",
                          state : ToastedStates.SUCCESS,
                        );
                      }
                    },
                    child: UserButton(
                      title: 'Continue',
                      method: () async{
                        if(formKey.currentState?.validate() == true){
                          Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(true);
                          try{
                            formKey.currentState?.save();
                            debugPrint(CustomerTextField.code.toString());
                            await AuthCubit.get(context).signInWithPhone( CustomerTextField.code + phone);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return VerifyPhone(phone: phone);
                                }
                            ));
                            Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(false);
                            // ignore: empty_catches
                          }catch(e){
                          }
                        }
                      },
                      color: green,
                    ),
                  ),
                  SizedBox(height: 7.sp,),
                ],
              ),
            ),
          )
      ),
    );
  }
}

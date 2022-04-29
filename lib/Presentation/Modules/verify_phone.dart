import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Domain/Auth/auth_state.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/Auth/auth_cubit.dart';
import '../Dialogs/AppToast.dart';
import '../Widgets/customer_button.dart';

// ignore: must_be_immutable
class VerifyPhone extends StatefulWidget {
  static String id = "VerifyPhone";
  late String  phone  ;
   VerifyPhone({Key? key , required this.phone}) : super(key: key);

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  late String country   ;
  OtpFieldController otpController = OtpFieldController();
  late String otp ;
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
                      "Verify Phone",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Code Is Sent To ${widget.phone}",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400 , color: grey),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60.sp,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: OTPTextField(
                        controller: otpController,
                        length: 6,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.box,
                        fieldWidth: MediaQuery.of(context).size.width * 0.13,
                        otpFieldStyle: OtpFieldStyle(
                          focusBorderColor: green,
                          backgroundColor: Colors.white,
                        ),
                        outlineBorderRadius: 15,
                        style: TextStyle(fontSize: 17.sp),
                        onChanged: (pin) {
                          debugPrint("Changed: " + pin);
                        },
                        onCompleted: (pin) async{
                          setState(() {
                            otp = pin;
                          });
                          try{
                            Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(true);
                            debugPrint("Code : " + otp);
                            await AuthCubit.get(context).submitOTP(otp);
                          }
                          catch(e){
                            showToastError(
                                state: ToastedStates.ERROR,
                                msg: e.toString()
                            );
                          }
                          Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(false);
                        }),
                  ),
                  SizedBox(height: 3.sp,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Receive Code ? ",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                          },
                          child: Text(
                            "Resend Code",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocListener<AuthCubit , AuthStates>(
                    listener: (context, state) {
                      if(state is OTPSuccess){
                        showToastError(msg: "Verification succeeded", state: ToastedStates.SUCCESS);
                      }
                      else if(state is OTPSuccess){
                        showToastError(msg: state.toString(), state: ToastedStates.ERROR);
                      }
                    },
                    child:  UserButton(
                      title: 'Verify And Create Account',
                      method: () async{
                        try{
                          Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(true);
                          debugPrint("Code : " + otp);
                          await AuthCubit.get(context).submitOTP(otp);
                        }
                        catch(e){
                          showToastError(
                              state: ToastedStates.ERROR,
                              msg: e.toString()
                          );
                        }
                        Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(false);
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

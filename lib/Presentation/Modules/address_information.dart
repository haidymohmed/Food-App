import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Domain/AccountInfo/address_status.dart';
import 'package:restaurant_app/Domain/PlaceOrder/order_cubit.dart';
import 'package:restaurant_app/Domain/PlaceOrder/order_status.dart';
import 'package:restaurant_app/Presentation/Dialogs/AppToast.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/colors.dart';
import '../../Constants/user_responsive.dart';
import '../../Data/Models/Address.dart';
import '../../Data/Models/Order.dart';
import '../../Domain/AccountInfo/address_cubit.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/DarkTheme.dart';
import '../../Domain/DisplayCard/display_card_cubit.dart';
import '../../Language/locale_keys.g.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/customer_button.dart';
import '../Widgets/customer_textField.dart';
import '../Widgets/title_text_field.dart';
// ignore: must_be_immutable
class AddressInfo extends StatefulWidget {
  late String title , button;
  // ignore: prefer_typing_uninitialized_variables
  late var method;
  AddressInfo({Key? key}) : super(key: key);

  @override
  _AddressInfoState createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  GlobalKey<FormState> formKey =  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Address addressInfo = Address(fullName: '', street: '', location: '', specialMark: '', phone: '');
    debugPrint(addressInfo.fullName);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Provider.of<UserDarkTheme>(context).isDark? null  : background,
            body: ModalProgressHUD(
              progressIndicator: SpinKitFadingCircle(
                color: green,
                size: 50,
              ),
              inAsyncCall: Provider.of<AsyncCall>(context).inAsyncCall,
              child: SingleChildScrollView(
                child: BlocListener<OrderCubit , OrderStatus>(
                  listener: (context, state) {
                    
                  },
                  child: Column(
                    children: [
                      getAppBar(
                        title: "Address Details",
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              getAlignText(LocaleKeys.name.tr() , context),
                              CustomerTextField(
                                hint: "Full Name",
                                reedOnly: false,
                                isPhone: false,
                                scure: false,
                                suffixIcon: true,
                                peffixIconData: Icons.person,
                                onSaved: (v){
                                  if(formKey.currentState?.validate() == true){
                                    addressInfo.fullName = v.toString();
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
                              getAlignText(LocaleKeys.phone.tr() , context),
                              CustomerTextField(
                                hint: "Phone Number",
                                reedOnly: false,
                                isPhone: true,
                                scure: false,
                                suffixIcon: true,
                                onSaved: (v){
                                  if(formKey.currentState?.validate() == true){
                                    addressInfo.phone = v.toString();
                                  }
                                },
                                validator: (v){
                                  if(v.toString().isNotEmpty){
                                    if(v.toString().length > 10){
                                    }
                                    else {
                                      return "Invalid phone";
                                    }
                                  }
                                  else {
                                    return "Required *" ;
                                  }
                                },
                              ),
                              getAlignText("Location" , context),
                              CustomerTextField(
                                hint: "Search for Location",
                                reedOnly: false,
                                isPhone: false,
                                scure: false,
                                suffixIcon: true,
                                peffixIconData: Icons.navigation,
                                onSaved: (v){
                                  if(formKey.currentState?.validate() == true){
                                    addressInfo.location = v.toString();
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
                              getAlignText("Street" , context),
                              CustomerTextField(
                                hint: "Street Name",
                                reedOnly: false,
                                isPhone: false,
                                scure: false,
                                suffixIcon: true,
                                peffixIconData: Icons.person_pin_circle_rounded,
                                onSaved: (v){
                                  if(formKey.currentState?.validate() == true){
                                    addressInfo.street = v.toString();
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
                              getAlignText("Special Mark", context),
                              CustomerTextField(
                                hint: "Something Close To Here",
                                reedOnly: false,
                                isPhone: false,
                                scure: true,
                                suffixIcon: true,
                                peffixIconData: Icons.streetview_outlined,
                                onSaved: (v){
                                  if(formKey.currentState?.validate() == true){
                                    addressInfo.specialMark = v.toString();
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      BlocConsumer<AddressCubit , AddressStatus>(
                        listener: (BuildContext context, state) {
                          if(state is AddressSuccess){
                            showToastError(msg: "Saved Successfully", state: ToastedStates.SUCCESS);
                          }
                          else if( state is AddressFailed){
                            showToastError(msg:  state.msg , state: ToastedStates.ERROR);
                          }
                        },
                        builder: (context , state){
                          return UserButton(
                              title: "Save",
                              color: green,
                              method: () async {
                                Provider.of<AsyncCall>(context, listen: false).changeAsyncCall(true);
                                if(formKey.currentState?.validate() == true){
                                  formKey.currentState?.save();
                                  Order order = Order(
                                    address: addressInfo , 
                                    total: DisplayCardCubit.get(context).total,
                                    subTotal: DisplayCardCubit.get(context).subTotal,
                                  );
                                  try{
                                    await OrderCubit.get(context).placeOrder(order);
                                  }
                                  // ignore: empty_catches
                                  catch(e){
                                  }
                                }
                                Provider.of<AsyncCall>(context, listen: false).changeAsyncCall(false);
                              }
                          );
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                    ],
                  ),
                ),
              ),
            ),
        ),
    );
  }
}

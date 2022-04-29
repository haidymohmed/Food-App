import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Constants/route_id.dart';
import 'package:restaurant_app/Constants/user_responsive.dart';
import 'package:restaurant_app/Data/Models/product.dart';
import 'package:restaurant_app/Domain/AddToCard/card_cubit.dart';
import 'package:restaurant_app/Domain/DisplayCard/display_card_cubit.dart';
import 'package:restaurant_app/Domain/DisplayCard/display_card_states.dart';
import 'package:restaurant_app/Presentation/Dialogs/AppToast.dart';
import 'package:restaurant_app/Presentation/Modules/GetUserLocation.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Domain/DarkTheme.dart';
import '../../Domain/IncAndDecrementItem/inc_dec_item_cubit.dart';
import '../../Domain/UserLocation/location_cubit.dart';
import '../Widgets/customer_button.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int counter = 1 ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 35.sp,
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                child: Text(
                  "Heaven's Food",
                  style: GoogleFonts.tajawal(
                    fontSize: UserResponsive.get(context: context, mobile: 18.sp, tablet: 15.sp),
                    fontWeight: FontWeight.w700,
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.all(UserResponsive.get(context: context, mobile: 0.0, tablet: 5.sp)),
              child: ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(bottom: 5.sp),
                  child: Icon(
                    Icons.timer_rounded,
                    color: green,
                    size: UserResponsive.get(
                        context: context,
                        mobile: 20.sp,
                        tablet: 10.sp
                    ),
                  ),
                ),
                title: Text(
                  "Delivery / As soon As Possible",
                  style: UserTheme.get(
                      context: context,
                      fontSize: UserResponsive.get(context: context, mobile: 14.sp, tablet: 10.sp),
                      fontWight: FontWeight.w600,
                      colorBright: black,
                      colorDark: white
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: grey,
                  size: UserResponsive.get(
                    context: context,
                    mobile: 20.sp,
                    tablet: 10.sp
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(UserResponsive.get(context: context, mobile: 0.0, tablet: 5.sp)),
              child: InkWell(
                onTap: ()async{
                  await LocationCubit.get(context).checkLocation();
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const GetUserLocation()));
                },
                child: ListTile(
                  leading: Padding(
                    padding: EdgeInsets.only(bottom: 5.sp),
                    child: Icon(
                      Icons.location_on_rounded,
                      color: green,
                      size: UserResponsive.get(
                          context: context,
                          mobile: 20.sp,
                          tablet: 10.sp
                      ),
                    ),
                  ),
                  title: Text(
                    LocationCubit.get(context).locationSeted ? LocationCubit.get(context).address :"Set Location to Place Order" ,
                    style: UserTheme.get(
                        context: context,
                        fontSize: UserResponsive.get(context: context, mobile: 14.sp, tablet: 10.sp),
                        fontWight: FontWeight.w600,
                        colorBright: black,
                        colorDark: white
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: grey,
                    size: UserResponsive.get(
                        context: context,
                        mobile: 20.sp,
                        tablet: 10.sp
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                color: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade900 : white,
              ),
              margin: EdgeInsets.symmetric(
                  horizontal: UserResponsive.get(context: context, mobile: 15.sp, tablet: 10.sp)
              ),
              padding: EdgeInsets.all(5.sp),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: UserResponsive.get(context: context, mobile: 10.sp, tablet: 5.sp),
                            vertical: UserResponsive.get(context: context, mobile: 10.sp, tablet: 5.sp)
                        ),
                        child: Text(
                          "Your Order",
                          style: UserTheme.get(
                              context: context,
                              fontSize: UserResponsive.get(context: context, mobile: 15.sp, tablet: 10.sp),
                              fontWight: FontWeight.w600,
                              colorBright: black,
                              colorDark: white
                          ),
                        )
                    ),
                  ),
                  BlocBuilder<DisplayCardCubit , DisplayCardStatus>(
                      builder: (context, displayCard) {
                        if(displayCard is DisplayCardSLoaded){
                          return SizedBox(
                            height: displayCard.card.length *  70.sp,
                            child: Column(
                              children: [
                                for(var i = 0 ; i < displayCard.card.length ; i++)
                                  getCustomRow(displayCard.card[i]),
                              ],
                            ),
                          );
                        }
                        else if(displayCard is DisplayCardSFailed){
                          showToastError(msg: displayCard.msg, state: ToastedStates.ERROR);
                          return Container();
                        }
                        else{
                          return Text(
                            "Card is Empty",
                            style: GoogleFonts.tajawal(
                              fontSize: UserResponsive.get(context: context, mobile: 15.sp, tablet: 15.sp),
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }
                      }
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: UserResponsive.get(context: context, mobile: 20.sp, tablet: 10.sp),
                        left: UserResponsive.get(context: context, mobile: 5.sp, tablet: 5.sp),
                        bottom: UserResponsive.get(context: context, mobile: 2.sp, tablet: 2.sp),
                        right: UserResponsive.get(context: context, mobile: 5.sp, tablet: 5.sp)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: UserTheme.get(
                              context: context,
                              fontSize: 14.sp,
                              fontWight: FontWeight.w600,
                              colorBright: Colors.grey.shade600,
                              colorDark: Colors.grey.shade500
                          ),
                        ),
                        BlocBuilder<DisplayCardCubit , DisplayCardStatus>(
                            builder: (context, displayCard) {
                              return Text(
                                displayCard is DisplayCardSLoaded ? "${DisplayCardCubit.get(context).subTotal} EGP" : "0 EGP",
                                style: UserTheme.get(
                                    context: context,
                                    fontSize: 14.sp,
                                    fontWight: FontWeight.w600,
                                    colorBright: Colors.grey.shade600,
                                    colorDark: Colors.grey.shade500
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: UserResponsive.get(context: context, mobile: 20.sp, tablet: 5.sp),
                        left: UserResponsive.get(context: context, mobile: 5.sp, tablet: 5.sp),
                        bottom: UserResponsive.get(context: context, mobile: 2.sp, tablet: 2.sp),
                        right: UserResponsive.get(context: context, mobile: 5.sp, tablet: 5.sp)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery",
                          style: UserTheme.get(
                              context: context,
                              fontSize: 14.sp,
                              fontWight: FontWeight.w600,
                              colorBright: Colors.grey.shade600,
                              colorDark: Colors.grey.shade500
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          height: 15.sp,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(10.sp),
                              border: Border.all(color: grey)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Free",
                              style: GoogleFonts.tajawal(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: grey
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: UserResponsive.get(context: context, mobile: 20.sp, tablet: 5.sp),
                        left: UserResponsive.get(context: context, mobile: 5.sp, tablet: 5.sp),
                        bottom: UserResponsive.get(context: context, mobile: 2.sp, tablet: 2.sp),
                        right: UserResponsive.get(context: context, mobile: 5.sp, tablet: 5.sp)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: UserTheme.get(
                              context: context,
                              fontSize: 15.sp,
                              fontWight: FontWeight.w700,
                              colorBright: black,
                              colorDark: white
                          ),
                        ),
                        BlocBuilder<DisplayCardCubit , DisplayCardStatus>(
                            builder: (context, displayCard) {
                              return Text(
                                displayCard is DisplayCardSLoaded ? "${DisplayCardCubit.get(context).subTotal} EGP" : "0 EGP",
                                style: UserTheme.get(
                                    context: context,
                                    fontSize: 15.sp,
                                    fontWight: FontWeight.w700,
                                    colorBright: black,
                                    colorDark: white
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.sp),
            UserButton(
              title: 'Place Order',
              method: (){
                  Navigator.pushNamed(context, addressInfoPath);
              },
              color: green,
            )
          ],
        ),
      ),
    );
  }
  getCustomRow(Product product){
    return
      Container(
        width: MediaQuery.of(context).size.width,
        height: 60.sp,
        margin: EdgeInsets.symmetric(horizontal: 5.sp , vertical: 5.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: LayoutBuilder(
                  builder: (context, constraints) => Image.network(
                    product.image,
                    fit: BoxFit.fill,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                  )
              ),
            ),
            Expanded(
              flex: UserResponsive.get(
                  context: context,
                  mobile: 2,
                  tablet: 3
              ),
              child: Padding(
                padding:UserResponsive.get(
                    context: context,
                    mobile: const EdgeInsets.all(8.0),
                    tablet: EdgeInsets.all(8.sp)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name[context.locale.toString()].toString(),
                      style: UserTheme.get(
                          context: context,
                          fontSize: 12.sp,
                          fontWight: FontWeight.w700,
                          colorBright: black,
                          colorDark: white
                      ),
                    ),
                    Text(
                      "${product.price.toString()} EGP",
                      style: UserTheme.get(
                          context: context,
                          fontSize: 10.sp,
                          fontWight: FontWeight.w500,
                          colorBright: Colors.grey.shade700,
                          colorDark: Colors.grey.shade500
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        constraints: BoxConstraints.tight(Size(15.sp,15.sp)),
                        decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(5.sp)
                        ),
                        child: InkWell(
                          onTap: (){
                            IncDecItemCubit.get(context).decrementProduct(product);
                          },
                          child: Icon(
                            Icons.remove,
                            size: 15.sp,
                            color: white,
                          ),
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.sp , vertical: 5.sp),
                      child: Text(
                        product.quantity.toString(),
                        style: UserTheme.get(
                            context: context,
                            fontSize: 13.sp,
                            fontWight: FontWeight.w500,
                            colorBright: black,
                            colorDark: white
                        ),
                      ),
                    ),
                    Container(
                        constraints: BoxConstraints.tight(Size(15.sp,15.sp)),
                        decoration: BoxDecoration(
                            color: green,
                          borderRadius: BorderRadius.circular(5.sp)
                        ),
                        child: InkWell(
                          onTap: (){
                            IncDecItemCubit.get(context).incrementProduct(product, context);
                          },
                          child: Icon(
                            Icons.add,
                            size: 15.sp,
                            color: white,
                          ),
                        )
                    ),
                    SizedBox(width: 5.sp,),
                    Container(
                      constraints: BoxConstraints.tight(Size(15.sp,15.sp)),
                      margin: EdgeInsets.symmetric(
                        horizontal: UserResponsive.get(
                            context: context,
                            mobile: 0.sp,
                            tablet: 5.sp
                        )
                      ),
                      child: InkWell(
                          onTap : (){
                            CardCubit.get(context).deleteItemFromCard(product);
                          },
                          child : Icon(
                            Icons.delete,
                            size: UserResponsive.get(
                              context: context,
                              mobile: 17.sp,
                              tablet: 18.sp
                            ),
                            color: grey,
                          )
                      )
                    )
                  ]
                )
              )
            )
          ]
        )
      );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:restaurant_app/Constants/user_responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Data/Models/product.dart';
import '../../Domain/AddToCard/card_cubit.dart';
import '../../Domain/AddToFavorites/favorite_cubit.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/DisplayFavorite/display_favorite_cubit.dart';
import '../../Domain/DisplayFavorite/display_favorite_status.dart';
import '../Dialogs/AppToast.dart';
import '../Widgets/customer_button.dart';

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  late Product product ;
  ProductScreen({Key? key , required this.product}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: Provider
            .of<AsyncCall>(context)
            .inAsyncCall,
        progressIndicator: SpinKitFadingCircle(
          color: green,
          size: 50,
        ),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.335,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                widget.product.image
                            ),
                          fit: BoxFit.cover
                        )
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap : (){
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 18.sp,
                                  color: white,
                                ),
                              ),
                              BlocBuilder<DisplayFavoriteCubit , DisplayFavoriteStatus>(
                                  builder: (context , displayFav) {
                                    if(displayFav is DisplayFavoriteSuccess){
                                      if(displayFav.ids.isNotEmpty){
                                        if(displayFav.ids.contains(widget.product.id)){
                                          return InkWell(
                                              onTap: () async {
                                                try{
                                                  await FavoriteCubit.get(context).deleteFromFavorite(widget.product );
                                                }
                                                catch(e){
                                                  showToastError(
                                                      msg: e.toString(),
                                                      state: ToastedStates.ERROR
                                                  );
                                                }
                                              },
                                              child: Center(
                                                child:  Icon(
                                                  Icons.favorite ,
                                                  color: Colors.red,
                                                  size: UserResponsive.get(
                                                      context: context,
                                                      mobile: 20.sp,
                                                      tablet: 13.sp
                                                  ),
                                                ),
                                              )
                                          );
                                        }
                                        else {
                                          return InkWell(
                                              onTap: () async {
                                                try{
                                                  await FavoriteCubit.get(context).addToFavorite(widget.product );
                                                }
                                                catch(e){
                                                  showToastError(
                                                      msg: e.toString(),
                                                      state: ToastedStates.ERROR
                                                  );
                                                }
                                              },
                                              child: Center(
                                                child:  Icon(
                                                  Icons.favorite_border ,
                                                  color: Colors.red,
                                                  size: UserResponsive.get(
                                                      context: context,
                                                      mobile: 20.sp,
                                                      tablet: 13.sp
                                                  ),
                                                ),
                                              )
                                          );
                                        }
                                      }
                                      else{
                                        return InkWell(
                                            onTap: () async {
                                              try{
                                                await FavoriteCubit.get(context).addToFavorite(widget.product );
                                              }
                                              catch(e){
                                                showToastError(
                                                    msg: e.toString(),
                                                    state: ToastedStates.ERROR
                                                );
                                              }
                                            },
                                            child: Center(
                                              child:  Icon(
                                                Icons.favorite_border ,
                                                color: Colors.red,
                                                size: UserResponsive.get(
                                                    context: context,
                                                    mobile: 20.sp,
                                                    tablet: 13.sp
                                                ),
                                              ),
                                            )
                                        );
                                      }
                                    }
                                    else {
                                      return InkWell(
                                          onTap: () async {
                                            try{
                                              await FavoriteCubit.get(context).addToFavorite(widget.product );
                                            }
                                            catch(e){
                                              showToastError(
                                                  msg: e.toString(),
                                                  state: ToastedStates.ERROR
                                              );
                                            }
                                          },
                                          child: Center(
                                            child:  Icon(
                                              Icons.favorite_border ,
                                              color: Colors.red,
                                              size: UserResponsive.get(
                                                  context: context,
                                                  mobile: 20.sp,
                                                  tablet: 13.sp
                                              ),
                                            ),
                                          )
                                      );
                                    }
                                  }
                              )
                            ],
                          ),
                        ),
                        Expanded(child: Container(),)
                      ],
                    )
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 14.sp,
                        right: 14.sp,
                        left: 14.sp
                    ),
                    child: Text(
                      widget.product.name[context.locale.toString()].toString(),
                      style: GoogleFonts.tajawal(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 14.sp
                  ),
                  child: Text(
                    widget.product.description[context.locale.toString()].toString(),
                    style: UserTheme.get(
                      context : context,
                        fontWight: FontWeight.w400,
                        fontSize: 12.sp,
                        colorBright: black,
                        colorDark: white
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical : 14.sp,
                    horizontal: 10.sp
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getPro(title: "Calories", rate: widget.product.cale),
                      getPro(title: "Protein", rate: widget.product.protein),
                      getPro(title: "Carbs", rate: widget.product.carb),
                      getPro(title: "Fat", rate: widget.product.fat),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.symmetric(
                    vertical: 5.sp
                  ),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20.sp)
                  ),
                  child: ExpansionTile(
                    textColor: black,
                    subtitle: Text(
                      "Required ",
                      style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.bold,
                        color: grey,
                      ),
                    ),
                    title: Text(
                      "Side 1",
                      style: GoogleFonts.tajawal(
                        fontSize:   15.sp,
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    children: <Widget>[
                      Column(
                        children: [
                          Divider(height: 3.sp,),
                          getSideList(
                              title: "Rise",
                              checked: widget.product.needRise,
                              method:  (v){
                                setState(() {
                                  widget.product.needRise = v ;
                                });
                              }
                          ),
                          getSideList(
                            title: "Pasta",
                            checked: widget.product.needPasta,
                            method: (v){
                              setState(() {
                                widget.product.needPasta = v ;
                              });
                            },
                          ),
                          getSideList(
                              title: "Salad",
                              checked: widget.product.needSalad,
                              method: (v){
                                setState(() {
                                  widget.product.needSalad = v ;
                                });
                              }
                              ),
                          getSideList(
                            title: "Potatos",
                              checked: widget.product.needPotatoes,
                              method: (v){
                              setState(() {
                                widget.product.needPotatoes = v ;
                              });
                          }
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.symmetric(
                      vertical: 5.sp
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp)
                  ),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: "Comment for Ordering ... ",
                      hintStyle:TextStyle(
                        fontSize: 13.sp,
                      ) ,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
                UserButton(
                    title: "Add (1) To Card - ${widget.product.price.toString()} Egp",
                    color: green,
                    method: (){
                      try{
                        CardCubit.get(context).insertItemToCard(widget.product);
                      }
                      // ignore: empty_catches
                      catch(e){
                      }
                    }
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
  getSideList({title, checked, method}){
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20.sp
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic
            ),
          ),
          Checkbox(
              value: checked,
              activeColor: Colors.green,
              onChanged: method,
          )
        ],
      ),
    );
  }
  getPro({required title, required rate }) {
    return Column(
      children: [
        Container(
          height: UserResponsive.width(context) * 0.18,
          width: UserResponsive.width(context) * 0.18,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33.sp),
              color: green
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: (UserResponsive.width(context) * 0.08),
                backgroundColor: white,
                child: Text(
                  rate.toString(),
                  style: UserTheme.get(
                      context: context,
                      fontWight: FontWeight.w600,
                      fontSize: 15.sp,
                      colorBright: black,
                      colorDark: black
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 6.sp,),
        Text(
          title,
          style: UserTheme.get(
              context: context,
              fontWight: FontWeight.w600,
              fontSize: 12.sp,
              colorBright: black,
              colorDark: white
          ),
        )
      ],
    );
  }
}

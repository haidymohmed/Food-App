import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Constants/user_responsive.dart';
import 'package:restaurant_app/Domain/Categories/categories_status.dart';
import 'package:restaurant_app/Domain/DisplayFavorite/display_favorite_status.dart';
import 'package:restaurant_app/Domain/Product/products_states.dart';
import 'package:restaurant_app/Presentation/Modules/product.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../Constants/image_path.dart';
import '../../Constants/route_id.dart';
import '../../Data/API/CategoryAPI.dart';
import '../../Data/Models/product.dart';
import '../../Domain/AddToCard/card_cubit.dart';
import '../../Domain/AddToCard/card_state.dart';
import '../../Domain/AddToFavorites/favorite_cubit.dart';
import '../../Domain/Categories/categories_cubit.dart';
import '../../Domain/DarkTheme.dart';
import '../../Domain/DisplayFavorite/display_favorite_cubit.dart';
import '../../Domain/Product/product_cubit.dart';
import '../../Language/locale_keys.g.dart';
import '../Dialogs/AppToast.dart';
import 'categoryScreen.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  CategoryAPI categoryAPI = CategoryAPI();
  double rate1 = 4;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: UserResponsive.get(
                context: context,
                mobile: 10.sp,
                tablet: 10.sp
            ),
            vertical: UserResponsive.get(
                context: context,
                mobile: 5.sp,
                tablet: 1.sp
            )
          ),
          child: Text(
              LocaleKeys.category.tr(),
            style: GoogleFonts.tajawal(
                fontSize: UserResponsive.get(
                    context: context,
                    mobile: 15.sp,
                    tablet: 13.sp
                ),
                fontWeight: FontWeight.w700,
              ),
            )
          ),
        BlocBuilder<CategoryCubit ,CategoryStates>(
          builder: (context , states){
            if(states is CategoryLoaded){
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: UserResponsive.get(
                      context: context,
                      mobile: UserResponsive.height(context) * 0.19,
                      tablet: UserResponsive.height(context) * 0.23
                  ),
                  padding: EdgeInsets.all(5.sp),
                  child: ListView.builder(
                      itemCount: states.categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context , index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryScreen( category : states.categories[index])
                                )
                            );
                          },
                          child: Container(
                            width: UserResponsive.get(
                                context: context,
                                mobile: UserResponsive.width(context) * 0.34,
                                tablet: UserResponsive.width(context) * 0.27
                            ),
                            height: MediaQuery.of(context).size.height * 0.19,
                            margin: EdgeInsets.all(3.sp),
                            decoration: BoxDecoration(
                                color: states.categories[index].color,
                                borderRadius: BorderRadius.circular(10.sp)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 5.sp),
                                  child: Text(
                                    " ${states.categories[index].name[context.locale.toString()]}",
                                    style: UserTheme.get(
                                        context: context,
                                        fontWight: FontWeight.w700,
                                        fontSize: 13.sp,
                                        colorBright: white,
                                        colorDark: white
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.network(
                                    states.categories[index].image.toString(),
                                    width: MediaQuery.of(context).size.width * 0.25,
                                    height: MediaQuery.of(context).size.height * 0.12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  )
              );
            }
            else if(states is CategoryFailed){
              return Text(
                  states.msg,
                style: UserTheme.get(
                  context : context,
                  fontSize: null,
                  fontWight: FontWeight.w600,
                  colorBright: black ,
                  colorDark: white
                ),
              );
            }
            else if(states is CategoryLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              return Container();
            }
          },
        ),
        Container(
            width: MediaQuery.of(context).size.width ,
            padding: EdgeInsets.symmetric(
                horizontal: 10.sp,
              vertical: 5.sp
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.bestSeller.tr(),
                  style: GoogleFonts.tajawal(
                    fontSize: UserResponsive.get(
                      context: context,
                      mobile: 15.sp,
                      tablet: 13.sp
                    ),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, viewProducts);
                  },
                  child: Text(
                    LocaleKeys.seeMore.tr(),
                    style: GoogleFonts.tajawal(
                      fontSize: UserResponsive.get(
                          context: context,
                          mobile: 13.sp,
                          tablet: 13.sp
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
        BlocBuilder<ProductCubit , ProductStates>(
            builder: (context, state) {
              if(state is ProductLoaded){
                return Container(
                    width: MediaQuery.of(context).size.width ,
                    padding: EdgeInsets.symmetric(horizontal: 5.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: getBestSeller(state.products[0]),
                        ),
                        Expanded(
                          child: getBestSeller(state.products[1]),
                        ),
                      ],
                    )
                );
              }
              else if (state is ProductLoading){
                return const Text("loading");
              }
              else if (state is ProductFailed){
                return const Text("error");
              }
              else{
                return const Text("null");
              }
            }),
        Container(
          width: MediaQuery.of(context).size.width,
          height: UserResponsive.get(
              context: context,
              mobile: UserResponsive.height(context) * 0.2,
              tablet: UserResponsive.height(context) * 0.22
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 10.sp,
            vertical: 5.sp
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: green,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex : 6,
                child: SizedBox(
                  height: UserResponsive.get(
                    context: context,
                    mobile: UserResponsive.height(context) * 0.2,
                    tablet: UserResponsive.height(context) * 0.22
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          LocaleKeys.healthFood.tr(),
                        style: UserTheme.get(
                            context: context,
                            fontSize: UserResponsive.get(
                                context: context,
                                mobile: 17.sp,
                                tablet: 15.sp
                            ),
                            fontWight: FontWeight.w900,
                            colorBright: white,
                            colorDark: white
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin : UserResponsive.get(
                            context: context,
                            mobile: EdgeInsets.all(6.sp),
                            tablet: EdgeInsets.symmetric(
                              horizontal: 20.sp
                            )
                        ),
                        padding : EdgeInsets.all(UserResponsive.get(
                            context: context,
                            mobile: 5.sp,
                            tablet: 3.sp
                        )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          color: Colors.black,
                        ),
                        child: Text(
                            LocaleKeys.viewOurMenu.tr(),
                          textAlign: TextAlign.center,
                          style: UserTheme.get(
                              context: context,
                              fontSize: UserResponsive.get(
                                  context: context,
                                  mobile: 13.sp,
                                  tablet: 10.sp
                              ),
                              fontWight: FontWeight.w600,
                              colorBright: white,
                              colorDark: white
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex : 4,
                child: SizedBox(
                  height: UserResponsive.get(
                      context: context,
                      mobile: UserResponsive.height(context) * 0.2,
                      tablet: UserResponsive.height(context) * 0.22
                  ),
                  child: Image.asset(
                    helathPath,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width ,
            padding: EdgeInsets.symmetric(
                horizontal: 10.sp,
                vertical: 5.sp
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.newArrival.tr(),
                  style: GoogleFonts.tajawal(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, newArrival);
                  },
                  child: Text(
                    LocaleKeys.seeMore.tr(),
                    style: GoogleFonts.tajawal(
                      fontSize: 13.sp,
                    ),
                  ),
                )
              ],
            )
        ),
        BlocBuilder<ProductCubit , ProductStates>(
          builder: (context, state) {
            if(state is ProductLoaded){
              return Container(
                  width: MediaQuery.of(context).size.width ,
                  padding: EdgeInsets.symmetric(horizontal: 5.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: getBestSeller(state.products[2]),
                      ),
                      Expanded(
                        child: getBestSeller(state.products[4]),
                      ),
                    ],
                  )
              );
            }
            else if (state is ProductLoading){
              return const Text("loading");
            }
            else if (state is ProductFailed){
              return const Text("error");
            }
            else{
              return const Text("null");
            }
          })
      ],
    );
  }
  getBestSeller(Product product){
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductScreen(product: product)
            )
        );
      },
      child: Container(
        padding: EdgeInsets.all(2.sp),
        margin: EdgeInsets.all(5.sp),
        height:UserResponsive.get(
            context: context,
            mobile: UserResponsive.height(context) * 0.3,
            tablet: UserResponsive.height(context) * 0.35
        ),
        decoration: BoxDecoration(
            color: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade800 :  Colors.white,
          borderRadius: BorderRadius.circular(10.sp)
        ),
        child: Badge(
          badgeColor: background.withOpacity(0.6),
          position: const BadgePosition(
              top: 5,
              start: 5
          ),
          elevation: 0,
          badgeContent: BlocBuilder<DisplayFavoriteCubit , DisplayFavoriteStatus>(
            builder: (context , displayFav) {
              if(displayFav is DisplayFavoriteSuccess){
                if(displayFav.ids.isNotEmpty){
                  if(displayFav.ids.contains(product.id)){
                    return InkWell(
                        onTap: () async {
                          try{
                            await FavoriteCubit.get(context).deleteFromFavorite(product );
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
                                mobile: 12.sp,
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
                          await FavoriteCubit.get(context).addToFavorite(product );
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
                              mobile: 12.sp,
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
                          await FavoriteCubit.get(context).addToFavorite(product );
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
                              mobile: 12.sp,
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
                      await FavoriteCubit.get(context).addToFavorite(product );
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
                          mobile: 12.sp,
                          tablet: 13.sp
                      ),
                    ),
                  )
              );
              }
            }
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                  child: LayoutBuilder(
                      builder: (context , constrains) {
                        return SizedBox(
                            width: constrains.maxWidth,
                            height: constrains.maxHeight,
                            child: Image.network(product.image , fit: BoxFit.fill,)
                        );
                      }
                  ),
              ),
              Expanded(
                flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(6.sp),
                    child: Text(
                      product.name[context.locale.toString()].toString(),
                      textAlign: TextAlign.center,
                      style: UserTheme.get(
                          context: context,
                          fontSize: UserResponsive.get(
                              context: context,
                              mobile: 13.sp,
                              tablet: 10.sp
                          ),
                          fontWight: FontWeight.w700,
                          colorBright: black,
                          colorDark: white,
                      ),
                    ),
                  ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: RatingBar.builder(
                                  initialRating: rate1,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: UserResponsive.get(
                                        context: context,
                                        mobile: 24.sp,
                                        tablet: 24.sp
                                    ),
                                  ),
                                  itemSize: UserResponsive.get(
                                      context: context,
                                      mobile: 10.sp,
                                      tablet: 10.sp
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      rate1 = rating;
                                    });
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product.price}",
                                    style: UserTheme.get(
                                      context: context,
                                      fontSize: UserResponsive.get(
                                          context: context,
                                          mobile: 13.sp,
                                          tablet: 10.sp
                                      ),
                                      fontWight: FontWeight.w700,
                                      colorDark: green,
                                      colorBright: green
                                    ),
                                  ),
                                  Text(
                                    " "+ LocaleKeys.egp.tr(),
                                    style: UserTheme.get(
                                        context: context,
                                        fontSize: UserResponsive.get(
                                            context: context,
                                            mobile: 13.sp,
                                            tablet: 10.sp
                                        ),
                                        fontWight: FontWeight.w700,
                                        colorDark: null,
                                        colorBright: null
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                    ),
                    Expanded(
                      flex: 1,
                      child: BlocBuilder<CardCubit , CardStatus>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: (){
                              CardCubit.get(context).insertItemToCard(product);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 3.sp),
                              height: UserResponsive.get(
                                  context: context,
                                  mobile: 30.sp,
                                  tablet: 20.sp
                              ),
                              width: UserResponsive.get(
                                  context: context,
                                  mobile: 30.sp,
                                  tablet: 20.sp
                              ),
                              decoration: BoxDecoration(
                                color: green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.all(3.sp),
                              child: Icon(
                                Icons.add_shopping_cart_outlined,
                                color: Colors.white,
                                size: UserResponsive.get(
                                    context: context,
                                    mobile: 15.sp,
                                    tablet: 12.sp
                                ),
                              ),
                            ),
                          );
                        }),
                      )
                  ],
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}

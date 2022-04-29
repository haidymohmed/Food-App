import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Constants/CustomerTheme.dart';
import 'package:restaurant_app/Constants/user_responsive.dart';
import 'package:restaurant_app/Data/Models/product.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:restaurant_app/Domain/Product/product_cubit.dart';
import 'package:restaurant_app/Domain/Product/products_states.dart';
import 'package:restaurant_app/Presentation/Modules/product.dart';
import 'package:restaurant_app/Presentation/Widgets/custom_appbar.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/colors.dart';
import '../../Data/Models/category.dart';
import '../../Domain/AddToCard/card_cubit.dart';
import '../../Domain/AddToCard/card_state.dart';
import '../../Domain/AddToFavorites/favorite_cubit.dart';
import '../../Domain/DarkTheme.dart';
import '../../Language/locale_keys.g.dart';
import '../Dialogs/AppToast.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatefulWidget {
  late Category category;
  CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Product> products = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children:[
            getAppBar(
                context: context,
                perffix: InkWell(
                    onTap: (){},
                    child: Icon(
                      Icons.arrow_back ,
                      color:Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade300 : Colors.black,
                      size: UserResponsive.get(
                          context: context,
                          mobile: 17.sp,
                          tablet: 13.sp
                      ),
                    )
                ),
                suffix: Container(width: 35,),
                title: widget.category.name[context.locale.toString()]
            ),
            Expanded(
              child: BlocBuilder<ProductCubit ,ProductStates>(
                  builder: (context, state) {
                    products.clear();
                    if(state is ProductLoaded){
                      for(var item in state.products){
                        if(item.category == widget.category.id){
                          products.add(item);
                        }
                      }
                      if(products.isNotEmpty){
                        return GridView.builder(
                            itemCount: products.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.83
                            ),
                            itemBuilder: (context , index){
                              return InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ProductScreen(product: products[index])
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
                                      badgeContent: InkWell(
                                          onTap: () async {
                                            try{
                                              await FavoriteCubit.get(context).addToFavorite(products[index]);
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
                                                      child: Image.network(products[index].image , fit: BoxFit.fill,)
                                                  );
                                                }
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(6.sp),
                                              child: Text(
                                                products[index].name[context.locale.toString()].toString(),
                                                textAlign: TextAlign.center,
                                                style: UserTheme.get(
                                                  context: context,
                                                  fontSize: UserResponsive.get(
                                                      context: context,
                                                      mobile: 13.sp,
                                                      tablet: 10.sp
                                                  ),
                                                  fontWight: FontWeight.w700,
                                                  colorBright: white,
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
                                                              initialRating: 5.9,
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
                                                                  products[index].rate = rating;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${products[index].price}",
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
                                                        builder: (context, cardState) {
                                                          return InkWell(
                                                            onTap: (){
                                                              CardCubit.get(context).insertItemToCard(products[index]);
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
                        );
                      }else{
                        return Center(
                          child: Text(
                            "There is no Products yet",
                            style: UserTheme.get(
                              context: context,
                              fontSize: UserResponsive.get(
                                  context: context,
                                  mobile: 15.sp,
                                  tablet: 12.sp
                              ),
                              fontWight: FontWeight.w600,
                              colorBright: black,
                              colorDark: white,
                            ),
                          ),
                        );
                      }
                    }
                    else if (state is ProductLoading){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else{
                      return const Center(
                          child: Text(
                              "Something went wrong"
                          )
                      );
                    }
                  }
              ),
            ),
          ]
        ),
      )
    );
  }
}

import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Constants/user_responsive.dart';
import 'package:restaurant_app/Domain/DisplayFavorite/display_favorite_cubit.dart';
import 'package:restaurant_app/Domain/DisplayFavorite/display_favorite_status.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Domain/AddToFavorites/favorite_cubit.dart';
import '../../Domain/DarkTheme.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color:  Provider.of<UserDarkTheme>(context).isDark
              ? null
              : background,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<DisplayFavoriteCubit , DisplayFavoriteStatus>(
                    builder: (context, displayFavorite) {
                      if (displayFavorite is DisplayFavoriteSuccess) {
                        if (displayFavorite.favorites.isNotEmpty) {
                          return GridView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: displayFavorite.favorites.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.83),
                              itemBuilder: (_, index) {
                                return Container(
                                  padding: EdgeInsets.all(2.sp),
                                  margin: EdgeInsets.all(5.sp),
                                  decoration: BoxDecoration(
                                      color: Provider.of<UserDarkTheme>(context).isDark
                                          ? Colors.grey.shade800
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10.sp)
                                  ),
                                  child: Badge(
                                    badgeColor: background.withOpacity(0.6),
                                    position: const BadgePosition(top: 5, start: 5),
                                    elevation: 0,
                                    badgeContent: InkWell(
                                        onTap: () {
                                          FavoriteCubit.get(context).deleteFromFavorite(displayFavorite.favorites[index]);
                                        },
                                        child: const Center(
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                        )),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: LayoutBuilder(builder: (context, constrains) {
                                            return SizedBox(
                                                width: constrains.maxWidth,
                                                height: constrains.maxHeight,
                                                child: Image.network(
                                                  displayFavorite.favorites[index].image,
                                                  fit: BoxFit.fill,
                                                ));
                                          }),
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
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          displayFavorite.favorites[index].name[context.locale.toString()].toString(),
                                                          style: UserTheme.get(
                                                              context: context,
                                                              fontSize: 13.sp,
                                                              fontWight: FontWeight.w700,
                                                              colorDark: white,
                                                              colorBright: black),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                "${displayFavorite.favorites[index].price}",
                                                                style: UserTheme.get(
                                                                    context: context,
                                                                    fontSize: 13.sp,
                                                                    fontWight:
                                                                    FontWeight.w700,
                                                                    colorDark: green,
                                                                    colorBright: green)),
                                                            Text(" EGP",
                                                                style: UserTheme.get(
                                                                    context: context,
                                                                    fontSize: 13.sp,
                                                                    fontWight:
                                                                    FontWeight.w700,
                                                                    colorDark: null,
                                                                    colorBright: null))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    margin: EdgeInsets.only(right: 3.sp),
                                                    height: UserResponsive.get(
                                                        context: context,
                                                        mobile: 30.sp,
                                                        tablet: 20.sp),
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
                                                          tablet: 12.sp),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        }
                        else {
                          return const Center(
                            child: Text("Favorite is Empty"),
                          );
                        }
                      }
                      else if (displayFavorite is DisplayFavoriteFailed) {
                        return Text(displayFavorite.msg.toString());
                      }
                      else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                ),
              )
            ],
          ),
        )
      )
    );
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:restaurant_app/Domain/DisplayFavorite/display_favorite_status.dart';
import '../../Data/API/favoriteAPI.dart';
import '../../Data/Models/product.dart';
class DisplayFavoriteCubit extends Cubit<DisplayFavoriteStatus>{
  late StreamSubscription<List<Product>> subscription ;
  DisplayFavoriteCubit() : super(DisplayFavoriteLoading()){
    FavoriteAPI favoriteAPI = FavoriteAPI();
    subscription = favoriteAPI.getFavoritesProduct().listen((card){
      List<String> ids = [];
      for(var fav in card){
        ids.add(fav.id);
      }
      emit(DisplayFavoriteSuccess(card , ids));
    })..onError((e){
      emit(DisplayFavoriteFailed(e.toString()));
    });
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/Data/API/ProductAPI.dart';
import 'package:restaurant_app/Data/API/favoriteAPI.dart';
import 'package:restaurant_app/Data/Models/product.dart';
import 'package:restaurant_app/Presentation/Dialogs/AppToast.dart';

import 'favorite_status.dart';

class FavoriteCubit extends Cubit<FavoriteStatus>{

  late StreamSubscription<List<Product>> subscription ;
  FavoriteCubit() : super(FavoriteProductLoading());
  static FavoriteCubit get(context) => BlocProvider.of(context);
  addToFavorite(Product product ){
    FavoriteAPI productAPI = FavoriteAPI();
    productAPI.insertToFavorite(product).then((value){
    }).catchError((error){
      showToastError(msg: "Failed", state: ToastedStates.ERROR);
    });
  }
  deleteFromFavorite(Product product){
    FavoriteAPI productAPI = FavoriteAPI();
     productAPI.deleteFromFavorite(product).then((value){
    }).catchError((error){
      showToastError(msg: "Failed", state: ToastedStates.ERROR);
    });
  }
  @override
  Future<void> close()async{
    await subscription.cancel();
    super.close();
  }
}

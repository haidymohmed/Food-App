import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/Data/API/cardAPI.dart';
import 'package:restaurant_app/Domain/DisplayCard/display_card_states.dart';
import '../../Data/Models/product.dart';
class DisplayCardCubit extends Cubit<DisplayCardStatus>{
  late StreamSubscription<List<Product>> subscription ;
  late double total = 0, subTotal = 0;
  static DisplayCardCubit get(context) => BlocProvider.of(context);
  DisplayCardCubit() : super(DisplayCardLoading()){
    CardAPI cardAPI = CardAPI();
    subscription = cardAPI.getCardsProduct().listen((card){
      total = 0;
      subTotal = 0;
      card.forEach((element) {
        total = (total + (element.price * element.quantity)).toDouble() ;
        subTotal = (subTotal + (element.price * element.quantity)).toDouble();
      });
      emit(DisplayCardSLoaded(card));
    })..onError((e){
      emit(DisplayCardSFailed(e.toString()));
    });
  }
}
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/Data/API/cardAPI.dart';
import 'package:restaurant_app/Data/Models/product.dart';
import 'card_state.dart';

class CardCubit extends Cubit<CardStatus>{
  late List<Product> orders;
  CardAPI cardAPI = CardAPI();
  CardCubit() : super(CardLoading());
  static CardCubit get(context) => BlocProvider.of(context);
  insertItemToCard(Product product){
    cardAPI.insertToCard(product ).then((value){
      emit(AddedSucceed());
    }).catchError((onError) {
      emit(AddedFailed(onError.toString()));
    });
  }
  deleteItemFromCard(Product product){
    cardAPI.deleteToCard(product).then((value){
      emit(DeletedSucceed());
    }).catchError((error) {
      emit(DeletedFailed(error.toString()));
    });
  }
}
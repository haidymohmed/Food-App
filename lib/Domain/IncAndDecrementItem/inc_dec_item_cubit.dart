import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/Data/Models/product.dart';
import 'package:restaurant_app/Domain/IncAndDecrementItem/inc_dec_item_status.dart';

import '../../Data/API/cardAPI.dart';

class IncDecItemCubit extends Cubit<IncDecItemStatus>{
  IncDecItemCubit() : super(IncDecItemLoading());
  static IncDecItemCubit get(context) => BlocProvider.of(context);
  incrementProduct(Product product, context){
    CardAPI cardAPI = CardAPI();
    cardAPI.getProduct(product).then((value){
      value.quantity = value.quantity + 1;
      cardAPI.setProduct(value).then((value){
        emit(DecrementedFailed());
      }).catchError((e){
        emit(IncrementedFailed());
      });
    }).catchError((e){
      emit(IncrementedFailed());
    });
  }
  decrementProduct(Product product){
    CardAPI cardAPI = CardAPI();
    cardAPI.getProduct(product).then((value){
      if(value.quantity > 1){
        value.quantity = value.quantity - 1;
      }
      cardAPI.setProduct(value).then((value){
        emit(DecrementedFailed());
      }).catchError((e){
        emit(IncrementedFailed());
      });
    }).catchError((e){
      emit(IncrementedFailed());
    });
  }
}
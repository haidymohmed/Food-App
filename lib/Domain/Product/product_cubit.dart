import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:restaurant_app/Data/API/ProductAPI.dart';
import 'package:restaurant_app/Data/Models/product.dart';
import 'package:restaurant_app/Domain/Product/products_states.dart';
class ProductCubit extends Cubit<ProductStates>{
  late StreamSubscription<List<Product>> subscription ;
  ProductCubit() : super(ProductLoading()){
    print("Try");
    subscription = ProductAPI().getProducts().listen((products){
      emit(ProductLoaded(products));
    })..onError((e){
      emit(ProductFailed(e));
    });
  }
  @override
  Future<void> close()async{
    await subscription.cancel();
    super.close();
  }
}
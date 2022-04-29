import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/Data/API/OrderAPI.dart';
import 'package:restaurant_app/Domain/PlaceOrder/order_status.dart';
import '../../Data/Models/Order.dart';

class OrderCubit extends Cubit<OrderStatus>{
  OrderCubit() : super(OrderLoading());
  static OrderCubit get(context) => BlocProvider.of(context);
  placeOrder(Order order){
    OrderAPI orderAPI = OrderAPI();
    orderAPI.copyCardToOrderCollection().then((v){
      emit(OrderPacedSuccess());
    }).catchError((FirebaseException f){
      emit(OrderPacedFailed());
    });
  }
}
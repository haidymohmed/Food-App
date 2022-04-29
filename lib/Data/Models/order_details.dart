import 'package:restaurant_app/Data/Models/product.dart';

class OrderDetails{
  late List<Product> order ;
  late var subTotal , total;
  bool placed = false ;
  late String adress;

}
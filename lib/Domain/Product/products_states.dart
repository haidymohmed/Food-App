import '../../Data/Models/product.dart';

abstract class ProductStates {}
class ProductLoading extends ProductStates{}
class ProductLoaded extends ProductStates{
  late final List<Product> products ;
  ProductLoaded(this.products);
}
class ProductFailed extends ProductStates{
  late final String msg ;
  ProductFailed(this.msg);
}
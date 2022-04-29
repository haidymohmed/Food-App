import '../../Data/Models/product.dart';

abstract class DisplayCardStatus {

}
class DisplayCardLoading extends DisplayCardStatus{

}
class DisplayCardSLoaded extends DisplayCardStatus{
  List<Product> card = [];
  DisplayCardSLoaded(this.card);
}
class DisplayCardSFailed extends DisplayCardStatus{
  String msg ;
  DisplayCardSFailed(this.msg);
}

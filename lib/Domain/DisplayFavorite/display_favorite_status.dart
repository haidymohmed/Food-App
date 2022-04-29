import 'package:restaurant_app/Data/Models/product.dart';
abstract class DisplayFavoriteStatus {}


class DisplayFavoriteLoading extends DisplayFavoriteStatus{}
class DisplayFavoriteSuccess extends DisplayFavoriteStatus{
  List<Product> favorites = [];
  List<String> ids = [];
  DisplayFavoriteSuccess(this.favorites , this.ids);
}
class DisplayFavoriteFailed extends DisplayFavoriteStatus{
  String msg ;
  DisplayFavoriteFailed(this.msg);
}
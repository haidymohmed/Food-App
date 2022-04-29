import '../../Data/Models/category.dart';

abstract class CategoryStates {}
class CategoryLoading extends CategoryStates{}
class CategoryLoaded extends CategoryStates{
  late final  List<Category> categories ;
  CategoryLoaded(this.categories);
}
class CategoryFailed extends CategoryStates{
  late final String msg ;
  CategoryFailed(this.msg);
}
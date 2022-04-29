import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:restaurant_app/Data/API/CategoryAPI.dart';
import '../../Data/Models/category.dart';
import 'categories_status.dart';

class CategoryCubit extends Cubit<CategoryStates>{
  late StreamSubscription<List<Category>> subscription ;
  CategoryCubit() : super(CategoryLoading()){
    subscription = CategoryAPI().getCategories().listen((category){
      emit(CategoryLoaded(category));
    })..onError((e){
      emit(CategoryFailed(e.toString()));
    });
  }
  @override
  Future<void> close()async{
    await subscription.cancel();
    super.close();
  }
}
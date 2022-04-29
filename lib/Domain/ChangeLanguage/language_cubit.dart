import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState>{
  static late Locale locale;
  bool isEnglish = true;
  static ChangeLanguageCubit get(context) => BlocProvider.of(context);

  ChangeLanguageCubit() : super(LoadingLanguage());
  changeLanguage(BuildContext context){
    if(context.locale.toString() == 'en'){
      isEnglish = false;
      context.setLocale(const Locale('ar'));
      emit(Arabic());
    }
    else if(context.locale.toString() == 'ar'){
      isEnglish = true;
      context.setLocale(const Locale('en'));
      emit(English());
    }
  }
  changeLanguage2({required BuildContext context , required currentLan }){
    if(currentLan == context.locale.toString()){}
    else{
      changeLanguage(context);
    }
  }
}
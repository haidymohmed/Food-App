// ignore: file_names
import 'package:flutter/cupertino.dart';

class UserDarkTheme extends ChangeNotifier{
  bool  isDark = false ;
  changeTheme(){
    isDark = !isDark;
    notifyListeners();
  }
}
import 'package:flutter/cupertino.dart';

class AsyncCall extends ChangeNotifier{
  bool  inAsyncCall = false ;
  changeAsyncCall(bool value){
    inAsyncCall = value;
    notifyListeners();
  }
}
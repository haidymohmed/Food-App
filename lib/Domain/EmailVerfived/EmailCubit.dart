import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Constants/localStorage.dart';
import '../../Data/LocalStorage/db_helper_sharedPrefrences.dart';
import 'EmailStatus.dart';

class EmailCubit extends Cubit<EmailStatus>{

  FirebaseAuth auth = FirebaseAuth.instance;
  EmailCubit() : super(LoadingEmail());

  checkVerify()async{
    emailVerified = auth.currentUser!.emailVerified;
    if(emailVerified == true){
      emit(VerifiedSuccess());
    }else{
      emit(VerifiedField());
    }
  }
}
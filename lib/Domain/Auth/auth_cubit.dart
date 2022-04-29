import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Data/LocalStorage/db_helper_sharedPrefrences.dart';
import 'package:restaurant_app/Data/Models/User.dart';
import '../../Constants/user_info.dart';
import '../../Presentation/Dialogs/AppToast.dart';
import 'auth_state.dart';
class AuthCubit extends Cubit<AuthStates>{
  late String id;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static AuthCubit get(context) => BlocProvider.of(context);
  FirebaseFirestore firebaseFireStore =FirebaseFirestore.instance;
  AuthCubit() : super(InitAuthState());
  signInWithPhone(phoneNumber)async{
    emit(PhoneLoading());
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential){
        auth.signInWithCredential(credential).then((value) {
          emit(OTPSuccess());
        });
      },
      verificationFailed: (FirebaseException error){
      emit(OTPFailed(error: error.message));
      },
      codeSent: (String phoneId , [int? token]){
        id = phoneId;
        emit(PhoneSuccess(phoneNumber: phoneNumber));
      },
      codeAutoRetrievalTimeout: (String c){
        emit(OTPFailed(error: "Timeout"));
      }
    );
  }
  logInWithEmail()async{
    await auth.signInWithEmailAndPassword(email: customerData.email, password: customerData.pass!).catchError(( e){
      showToastError(msg: e.toString(), state: ToastedStates.ERROR);
    }).then((value) async{
      customerData.id = value.user?.uid;
      await getUserData(customerData);
    });
  }
  submitOTP(otpCode){
    emit(OTPLoading());
    AuthCredential credential = PhoneAuthProvider.credential(verificationId: id , smsCode: otpCode.toString());
    auth.signInWithCredential(credential).then((value) => {
      if(value.user != null){

      }
    // ignore: argument_type_not_assignable_to_error_handler
    }).catchError((FirebaseAuthException e){
      showToastError(
          state: ToastedStates.ERROR,
          msg: e.message.toString()
      );
      emit(OTPFailed(error: e.message.toString()));
    });
  }
  createAccount()async{
    await auth.createUserWithEmailAndPassword(email: customerData.email, password: customerData.pass!).then((value) async {
      await auth.currentUser!.sendEmailVerification();
      customerData.id = value.user?.uid;
      await firebaseFireStore.collection("Users").doc(value.user?.uid).set(customerData.toJson()).then((value){
        return ;
      }).onError((error, stackTrace){

        showToastError(msg: error.toString(), state: ToastedStates.ERROR);
      });
    // ignore: argument_type_not_assignable_to_error_handler
    }).catchError((Object e){
      showToastError(msg: e.toString(), state: ToastedStates.ERROR);
      return null;
    });
  }
  forgotPassword(email)async{
    // ignore: argument_type_not_assignable_to_error_handler
    await auth.sendPasswordResetEmail(email: email).catchError((FirebaseAuthException e){
      showToastError(msg: e.message.toString(), state: ToastedStates.ERROR);
    });
  }
  getUserData( UserDetails userDetails) async{
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userDetails.id)
        .get().then((value) {
      userDetails.phone =  value.get('phone');
      userDetails.name = value.get('name');
      userDetails.email = value.get('email');
      userDetails.id = value.get('id');
    }).catchError((onError){
      print("Error");
    });
  }
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
  signInWithFaceBook(){
    print("FaceBook");
  }
  signInWithApple(){
    auth.currentUser?.updatePassword("newPassword");
  }
  changePassword({required oldPass ,required newPass , msg = "Password"}) async{
     var email = await auth.currentUser?.email;
     AuthCredential credential = EmailAuthProvider.credential(email: email.toString(), password: oldPass );
     auth.currentUser?.reauthenticateWithCredential(credential).then((value) async{
       await auth.currentUser?.updatePassword(newPass).onError((FirebaseAuthException e, stackTrace) async {
         showToastError(
             msg: e.message.toString(),
             state: ToastedStates.ERROR
         );
         auth.currentUser?.reload();
       }).then((value) {
         showToastError(
             msg: "Password changed successfully",
             state: ToastedStates.SUCCESS
         );
       });
      }).onError((FirebaseAuthException e, stackTrace) {
       showToastError(
           msg: e.message.toString(),
           state: ToastedStates.ERROR
       );
     });
  }
  changeEmail({required oldPass ,required newEmail ,required newPass})async{
    var email = await auth.currentUser?.email;
    AuthCredential credential = await EmailAuthProvider.credential(email: email.toString(), password: oldPass);
    auth.currentUser?.reauthenticateWithCredential(credential).then((value) async{
      print(value.toString());
      await auth.currentUser?.updateEmail(newEmail).then((value) async {
        await auth.currentUser?.reload();
        await auth.currentUser?.updatePassword(newPass).onError((FirebaseAuthException e, stackTrace) {
          showToastError(
              msg: e.message.toString(),
              state: ToastedStates.ERROR
          );
          auth.currentUser?.reload();
        }).then((value) async {
          customerData.email = newEmail.toString();
          customerData.pass = newPass;
          await CacheHelper.setString("userEmail", newEmail);
          await CacheHelper.setString("userPassword", newPass);
          await firebaseFireStore.collection("Users").doc(auth.currentUser?.uid).update({"email": newEmail.toString()});
          showToastError(
              msg: "Email changed successfully",
              state: ToastedStates.SUCCESS
          );
        });
      // ignore: argument_type_not_assignable_to_error_handler
      }).catchError((FirebaseAuthException e, stackTrace) {
        showToastError(
            msg: e.message.toString(),
            state: ToastedStates.ERROR
        );
        auth.currentUser?.reload();
      });
    }).onError((FirebaseAuthException e, stackTrace) {
      showToastError(
          msg: e.message.toString(),
          state: ToastedStates.ERROR
      );
    });
  }
  signOut(){
    auth.signOut();
  }
}

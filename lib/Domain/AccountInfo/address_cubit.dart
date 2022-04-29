
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/Data/API/addressAPI.dart';
import 'package:restaurant_app/Domain/AccountInfo/address_status.dart';

import '../../Data/Models/Address.dart';
import '../../Presentation/Dialogs/AppToast.dart';

class AddressCubit extends Cubit<AddressStatus>{
  AddressCubit() : super(AddressLoading());
  static AddressCubit get(context) => BlocProvider.of(context) ;
  saveAddress(Address address){
    AddressApi addressApi = AddressApi();
    addressApi.setLocation(address).then((value){
      showToastError(msg: "Saved Successfully", state: ToastedStates.SUCCESS);
      emit(AddressSuccess());
    }).catchError((FirebaseException error, stackTrace) {
      showToastError(msg: error.message.toString(), state: ToastedStates.SUCCESS);
      emit(AddressFailed(error.message.toString()));
    });
  }
}
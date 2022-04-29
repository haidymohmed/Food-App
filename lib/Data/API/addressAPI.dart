
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_app/Constants/user_info.dart';

import '../Models/Address.dart';

class AddressApi {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  setLocation(Address address){
    return firebaseFirestore.collection("Users").doc(customerData.id).update(address.toJson());
  }
}
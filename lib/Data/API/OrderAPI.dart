import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_app/Constants/route_id.dart';
import 'package:restaurant_app/Constants/user_info.dart';
import 'package:restaurant_app/Data/Models/product.dart';
import 'package:restaurant_app/Presentation/Dialogs/AppToast.dart';
import '../Models/Order.dart';
class OrderAPI{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  setOrder(Order order){
  }
  copyCardToOrderCollection()async {
    List<Product> card = [];
    firebaseFirestore.collection("Users").doc(customerData.id).collection("Card").snapshots().map((event){
      event.docs.forEach((element) {
        print(element.id);
        card.add(Product.fromJason(element.data()));
      });
    });
  }
}
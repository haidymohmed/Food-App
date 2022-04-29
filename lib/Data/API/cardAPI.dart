import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_app/Data/Models/product.dart';
import '../../Constants/user_info.dart';

class CardAPI{

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  insertToCard(Product product){
    return firebaseFirestore.collection("Users").doc(customerData.id).collection("Card").doc(product.id).set(product.toJson());
  }
  deleteToCard(Product product ){
    return firebaseFirestore.collection("Users").doc(customerData.id).collection("Card").doc(product.id).delete();
  }
  getCardsProduct( ){
    return firebaseFirestore.collection("Users").doc(customerData.id).collection("Card").snapshots().map((event){
      List<Product> card = [];
      event.docs.forEach((element) {
        card.add(Product.fromJason(element.data()));
      });
      return card;
    });
  }
  getProduct(Product product ){
    return firebaseFirestore.collection("Users").doc(customerData.id).collection("Card").doc(product.id).get().then((value) {
      Product pro = Product.fromJason(value.data());
      return pro;
    });
  }
  setProduct(Product product){
    return firebaseFirestore.collection("Users").doc(customerData.id).collection("Card").doc(product.id).set(product.toJson());
  }
}
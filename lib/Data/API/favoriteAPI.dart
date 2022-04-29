import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Constants/user_info.dart';
import '../Models/product.dart';
class FavoriteAPI{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  insertToFavorite(Product product ){
    return firebaseFirestore.collection("Users").doc(customerData.id).
    collection("Favorites").doc(product.id).set(product.toJson());
  }
  deleteFromFavorite(Product product){
    return firebaseFirestore.collection("Users").doc(customerData.id).
    collection("Favorites").doc(product.id).delete();
  }
  getFavoritesProduct(){
    var ref = firebaseFirestore.collection("Users").doc(customerData.id).collection("Favorites");
    return ref.snapshots().map((event) {
      List<Product> favorites = [];
      event.docs.forEach((element2) {
        favorites.add(Product.fromJason(element2.data()));
      });
      return favorites;
    });
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/product.dart';
class ProductAPI {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  getProducts(){
    var ref = firebaseFirestore.collection("Products");
    return ref.snapshots().map((event) {
      List<Product> products = [];
      event.docs.forEach((element){
        var product = Product.fromJason(element);
        products.add(product);
      });
      return products;
    });
  }
}
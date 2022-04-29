import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/category.dart';
class CategoryAPI{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance ;
  getCategories(){
    var ref = firebaseFirestore.collection("Categories");
    return ref.snapshots().map((event)  {
      List<Category> categories = [];
      for (var element in event.docs) {
        var product = Category.fromJason(element.data());
        categories.add(product);
      }
      return categories;
    });
  }
}
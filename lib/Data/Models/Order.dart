import 'package:restaurant_app/Constants/user_info.dart';
import 'package:restaurant_app/Data/Models/product.dart';

import 'Address.dart';

class Order {
  var total , subTotal ;
  late Address address ;
  Order({
    required this.address ,
    required this.total,
    required this.subTotal,
  });
  toJson(){
    return{
      "id" : customerData.id,
      "email" : customerData.email,
      "fullName" : address.fullName,
      "location": address.location,
      "name": address.fullName,
      "street": address.street,
      "specialMark": address.specialMark,
      "phone": address.phone,
      "total" : total,
      "subTotal" : subTotal,
    };
  }
}
import 'dart:ui';
import 'package:flutter/material.dart';
class Category{
  late String  image , id ;
  late Color color ;
  late DateTime date;
  Map<String , String> name = {
    "en" : "",
    "ar" : "",
  };
  // ignore: non_constant_identifier_names
  Category({required this.image, required this.id , required this.color , required this.date , required this.name});
  Category.fromJason(data){
    color = Color(int.parse(data["color"].split('(0x')[1].split(')')[0], radix: 16));
    image = data["image"];
    id = data["id"];
    date = DateTime.now();
    name["en"] = data["name_en"];
    name["ar"] = data["name_ar"];
  }
}
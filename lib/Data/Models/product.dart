class Product{
  late String  id ,image , category ;
  late double  cale , protein , carb , fat , rate , price;
  late bool needRise , needPasta , needPotatoes ,needSalad  , isFavorite;
  DateTime? date;
  int quantity = 1;
  Map<String , String> name = {};
  Map<String , String> description = {};
  Product({
    required this.name,
    required this.description,
    required this.date,
    required this.id,
    required this.image,
    required this.category,
    required this.cale,
    required this.protein,
    required this.carb,
    required this.fat,
    required this.rate,
    required this.price,
    required this.needRise,
    required this.needPasta,
    required this.needPotatoes,
    required this.needSalad,
    required this.quantity,
    required this.isFavorite
  });

  toJson(){
    return {
      "id" : id,
      "image" : image,
      "category" : category,
      "cale" : cale,
      "pro" : protein,
      "carb" : carb,
      "fat" : fat,
      "rate" : rate,
      "price" : price,
      "needRise" : needRise,
      "needPasta" : needPasta,
      "needPotatos" : needPotatoes,
      "needSalad" : needSalad,
      "quantity" : quantity,
      "date" : date,
      "descriptionAr" : description["ar"],
      "descriptionEn" : description["en"],
      "nameAr" : name["ar"],
      "nameEn" : name["en"],
      "favorite" : isFavorite
    };
  }
  Product.fromJason(data){
    date = data['date'].toDate();
    id = data['id'];
    image = data['image'];
    category = data['category'];
    cale = data['cale'];
    protein = data['pro'];
    carb = data['carb'];
    fat = data['fat'];
    rate = data['rate'];
    price = data['price'];
    needRise = data['needRise'];
    needPasta = data['needPasta'];
    needPotatoes = data['needPotatos'];
    needSalad = data['needSalad'];
    quantity = data['quantity'];
    description["ar"] = data['descriptionAr'];
    description["en"] = data['descriptionEn'];
    name["ar"] = data['nameAr'];
    name["en"] = data['nameEn'];
    isFavorite = data['favorite'];
  }
}
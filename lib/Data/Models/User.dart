class UserDetails{
  late String email ;
  late String? pass , name , phone , id ;
  UserDetails({required this.name, required this.phone, required this.id, required this.email, required this.pass });
  toJson(){
    return {
      "name" :  name,
      "phone" : phone,
      "id" : id,
      "email" : email,
      "password" : pass
    };
  }
  UserDetails.fromJason(data){
    name = data["name"];
    phone = data["phone"];
    email = data["email"];
    id = data["id"];

  }
}
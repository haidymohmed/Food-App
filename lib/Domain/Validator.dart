class Validator{
  name(String name){
    if(name.isEmpty){
      return "Required";
    }
  }
  phone(String phone){
    if(phone.isEmpty){
      return "Required";
    }
    else if(phone.length < 10){
      return "Invalid Number";
    }
  }
}
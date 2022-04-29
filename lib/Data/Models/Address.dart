
class Address{
  late String location , fullName , street , specialMark , phone;
  Address({
    required this.fullName,
    required this.phone,
    required this.location,
    required this.street,
    required this.specialMark,
  });
  toJson() {
    return {
      "location": location,
      "fullName": fullName,
      "street": street,
      "specialMark": specialMark,
      "phone": phone
    };
  }
}
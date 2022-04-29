abstract class AddressStatus{}
class AddressLoading extends AddressStatus{}
class AddressSuccess extends AddressStatus{

}
class AddressFailed extends AddressStatus{
  late String msg ;
  AddressFailed(this.msg);
}

abstract class CardStatus {

}
class AddedSucceed extends CardStatus{

}
class AddedFailed extends CardStatus{
  String msg;
  AddedFailed(this.msg);
}
class CardLoading extends CardStatus{

}

class DeletedSucceed extends CardStatus{

}
class DeletedFailed extends CardStatus{
  String msg;
  DeletedFailed(this.msg);
}

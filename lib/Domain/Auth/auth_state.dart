abstract class AuthStates{}

class InitAuthState extends AuthStates{}

//PhoneAuth
class PhoneLoading extends AuthStates{}
class PhoneSuccess extends AuthStates{
  String phoneNumber ;
  PhoneSuccess({required this.phoneNumber});
}

class PhoneFailed extends AuthStates{}

class OTPLoading extends AuthStates{}
class OTPSuccess extends AuthStates{}
class OTPFailed extends AuthStates{
  String? error ;
  OTPFailed({required this.error});
}
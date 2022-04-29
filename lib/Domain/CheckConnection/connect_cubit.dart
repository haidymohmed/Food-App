import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'connect_state.dart';

class CheckConnectionCubit extends Cubit<CheckConnectionState>{
  final Connectivity connectivity = Connectivity();
  static late bool isConnected ;

  CheckConnectionCubit() : super(
      LoadingConnection()
  );
  initialConnection()async{
    connectivity.onConnectivityChanged.listen(connectChange);
  }
  Future<bool?> checkConnection(ConnectivityResult connectivityResult) async{
    if(ConnectivityResult.none == connectivityResult){
      isConnected = false;
      emit(DisConnected());
    }
    else{
      isConnected = true;
      emit(Connected());
    }
    return null;
  }
  connectChange(ConnectivityResult connectivityResult){
    print("check Connection");
    checkConnection(connectivityResult);
  }
}
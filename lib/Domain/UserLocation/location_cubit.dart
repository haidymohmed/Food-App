import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

import 'location_cubit.dart';
import 'location_statue.dart';

class LocationCubit extends Cubit<LocationStatue>{
  late bool locationSeted = false;
  late double longitude ,  latitude;
  late String address;
  LocationCubit() : super(LoadingLocation());

  static LocationCubit get(context) => BlocProvider.of(context);

  checkLocation()async{
    await Location().serviceEnabled().then((value) => {
      if(!value){
        Location().requestService()
      }
    }).catchError((onError){

    });

    await Location().hasPermission().then((value) => {
      if(value == PermissionStatus.denied){
        Location().requestPermission()
      }
    });
    await Location().getLocation().then((value) {
      latitude = value.latitude!;
      longitude = value.longitude!;
      GeoCode().reverseGeocoding(
        longitude: value.longitude!,
        latitude: value.latitude!,
        ).then((value) {
          address =  value.streetNumber!.toString() +" st " + value.streetAddress! + ", " + value.city! + ", " + value.streetAddress!;
        }).catchError((onError){
          print(onError.toString());
      });
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sizer/sizer.dart';
import 'package:latlong2/latlong.dart';
import '../../Constants/colors.dart';
import '../../Domain/UserLocation/location_cubit.dart';
import '../Widgets/customer_button.dart';
class GetUserLocation extends StatefulWidget {
  static String id = "GetUserLocation";
  const GetUserLocation({Key? key}) : super(key: key);

  @override
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width * 0.9 , 70.sp),
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: 10.sp,
                vertical: 15.sp
            ),
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: TextFormField(
              onSaved: (v){},
              validator: (v){
                return null;
              },
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                hintText: "search for location .. ",
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: black
                ) ,
                prefixIcon: const BackButton(color: black),
                suffixIcon: const Icon(
                  Icons.search,
                  color: black,
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
              ),
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(LocationCubit.get(context).latitude, LocationCubit.get(context).longitude),
                      zoom: 13.0,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                        attributionBuilder: (_) {
                          return const Text("© OpenStreetMap contributors");
                        },
                      ),
                      MarkerLayerOptions(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(LocationCubit.get(context).latitude, LocationCubit.get(context).longitude),
                            builder: (ctx) =>
                                Icon(
                                  Icons.location_on_rounded,
                                  color: green,
                                  size: 25.sp,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10.sp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: CircleAvatar(
                          child: InkWell(
                            onTap: (){
                              LocationCubit.get(context).checkLocation();
                            },
                            child: Icon(
                              Icons.my_location,
                              color: green,
                            ),
                          ),
                          radius: 25.sp,
                          backgroundColor: white,
                        ),
                      ),
                      UserButton(
                          title: "Confirm",
                          color: green,
                          method: (){
                            setState(() {
                              LocationCubit.get(context).locationSeted = true;
                            });
                            Navigator.pop(context);
                          }
                      )
                    ],
                  ),
                )
              ],
            );
          }
          ),
        ),
    );
  }
}

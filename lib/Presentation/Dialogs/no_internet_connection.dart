import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/fonts.dart';

// ignore: must_be_immutable
class ShowCustomerDialog extends StatelessWidget {
  bool dismiss ;
  late String title , subtitle;
  static BuildContext ?  context ;
  ShowCustomerDialog({Key? key , required this.dismiss , required this.title , required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => dismiss,
      child: AlertDialog(
        title: Text(
            title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: tajawalFont,
            fontWeight: FontWeight.w500,
            fontSize: 15.sp
          ),
        ),
        content: Text(
            subtitle,
          style: TextStyle(
            fontFamily: 'Tajawal',
              fontSize: 12.sp,
            fontWeight: FontWeight.normal
          ),
        ),
      ),
    );
  }
}

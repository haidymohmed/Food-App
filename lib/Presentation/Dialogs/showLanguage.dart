import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../Constants/colors.dart';
import 'dart:ui' as ui;
import '../../Constants/fonts.dart';
import '../../Domain/ChangeLanguage/language_cubit.dart';
class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({Key? key , }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: AlertDialog(
          title: Text(
            "Language",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: tajawalFont,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp
            ),
          ),
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: (){
                  ChangeLanguageCubit.get(context).changeLanguage2(context: context ,currentLan: "en");
                  Navigator.pop(context);
                },
                child: ListTile(
                  title: Text(
                    "English",
                    style: GoogleFonts.tajawal(
                        fontSize: 18.sp
                    ),
                  ),
                  trailing: context.locale.toString() == "en"? Icon(
                    Icons.check,
                    color: green,
                  ): null,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: (){
                  ChangeLanguageCubit.get(context).changeLanguage2(context : context ,currentLan : "ar");
                  Navigator.pop(context);
                },
                child: ListTile(
                  title: Text(
                    "Arabic",
                    style: GoogleFonts.tajawal(
                        fontSize: 18.sp
                    ),
                  ),
                  trailing: context.locale.toString() == "ar"? Icon(
                    Icons.check,
                    color: green,
                  ): null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

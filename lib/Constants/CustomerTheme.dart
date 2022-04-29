import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../Domain/DarkTheme.dart';
import 'colors.dart';

class UserTheme{
  static get({required context ,required fontSize , required fontWight ,required colorBright ,required colorDark}){
    return TextStyle(
      fontFamily: 'Tajawal',
      fontSize: fontSize,
      fontWeight: fontWight,
      color: Provider.of<UserDarkTheme>(context).isDark? colorDark : colorBright,
    );
  }
}
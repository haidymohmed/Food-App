import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../../../Domain/DarkTheme.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Language/locale_keys.g.dart';
// ignore: must_be_immutable
class CustomerTextField extends StatefulWidget {
  TextEditingController? contraller = TextEditingController();
  static var code = "+20";
  late String hint ;
  late bool scure , suffixIcon , isPhone;
  IconData? suffixIconData , peffixIconData;
  // ignore: prefer_typing_uninitialized_variables
  var validator , onSaved , onTap , country , reedOnly = false;
  CustomerTextField(
      {Key? key,
        required this.hint,
        required this.scure,
        required this.suffixIcon,
        required this.isPhone ,
        this.peffixIconData,
        this.suffixIconData,
        this.contraller ,
        this.country ,
        this.onTap,
        this.onSaved,
        required this.reedOnly,
        this.validator,
      }) : super(key: key);
  @override
  _CustomerTextFieldState createState() => _CustomerTextFieldState();
}

class _CustomerTextFieldState extends State<CustomerTextField> {
  late double w , h;
  _CustomerTextFieldState();
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1.sp,
              color: Provider.of<UserDarkTheme>(context).isDark?  Colors.grey.shade600 : Colors.grey.shade200
          ),
          color: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade800 : white,
          borderRadius: BorderRadius.circular(10)
      ),
      width: w > 600 ? w*0.6 : w*0.9,
      child: TextFormField(
        style: UserTheme.get(
            context: context,
            fontWight: FontWeight.w500,
            fontSize: w> 600 ? 10.sp : 13.sp,
            colorBright: black,
            colorDark: Colors.white
        ) ,
        cursorColor: Colors.grey,
        controller: widget.contraller,
        onSaved: widget.onSaved,
        validator: widget.validator,
        autofocus: widget.hint == "Number"? true : false,
        keyboardType: (widget.hint == "Number" || widget.hint == LocaleKeys.enterYourPhone.tr())? TextInputType.number : TextInputType.text,
        onTap: widget.onTap,
        obscureText: widget.scure ,
        readOnly: widget.reedOnly,
        textAlignVertical: w > 600 ? TextAlignVertical.bottom : TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: UserTheme.get(
              context: context,
              fontWight: FontWeight.w500,
              fontSize: w> 600 ? 10.sp : 13.sp,
              colorBright: black,
              colorDark: Colors.grey.shade600
          ) ,
          prefixIcon: widget.isPhone?
          countryCard() :
          widget.peffixIconData != null ? Padding(
            padding: EdgeInsets.all(2.sp),
            child: Icon(
              widget.peffixIconData ,
              color: Colors.grey,
              size: w> 600 ? 12.sp :20.sp,
            ),
          ) : null,
          suffixIcon: widget.suffixIconData != null ? InkWell(
            onTap: (){
              setState(() {
                widget.scure = ! widget.scure;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(2.sp),
              child: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
                size:w> 600 ? 12.sp :20.sp,
              ),
            ),
          ) : null ,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }
  Widget countryCard(){
    return CountryCodePicker(
      onChanged: (CountryCode code){
        setState(() {
          widget.country = code.toString();
          widget.hint  = code.name!;
          CustomerTextField.code = code.dialCode!;
          debugPrint(CustomerTextField.code);
        });
      },
      barrierColor: Colors.grey.shade300,
      initialSelection: widget.country,
      showOnlyCountryWhenClosed: false,
    );
  }
}
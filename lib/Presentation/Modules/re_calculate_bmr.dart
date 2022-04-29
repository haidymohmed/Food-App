import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/user_responsive.dart';
import '../../Data/Models/bmr_model.dart';
import '../../Domain/BMRCalcoluator.dart';
import '../../Domain/DarkTheme.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/customer_button.dart';

class RecalculateBMR extends StatefulWidget {
  const RecalculateBMR({Key? key}) : super(key: key);

  @override
  _RecalculateBMRState createState() => _RecalculateBMRState();
}

class _RecalculateBMRState extends State<RecalculateBMR> {
  CalcBMR calcBMR = CalcBMR();
  bool calculated = false;
  BMR bmr = BMR(height: 0, weight: 0, age: 0, gen: gender.Female);
  int group = 0;
  late double calculatedBMR ;
  GlobalKey<FormState> formKey =  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Provider.of<UserDarkTheme>(context).isDark? null  : background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              getAppBar(
                  context: context,
                  perffix: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: UserResponsive.get(
                            context: context,
                            mobile: 17.sp,
                            tablet: 13.sp
                        ),
                      )
                  ),
                  suffix: Container(width: 30.sp,),
                  title: "BMR"
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
              SizedBox(
                width: UserResponsive.get(
                    context: context,
                    mobile:  UserResponsive.width(context),
                    tablet: UserResponsive.width(context) * 0.8
                ),
                child: Form(
                  key: formKey,
                    child: Column(
                      children: [
                        getItem(
                            title: "Gender",
                            iconDate: Icons.height,
                            isGender: true,
                            unit: "cm",
                          save: (v){
                          }
                        ),
                        getItem(
                          title: "Height",
                          iconDate: Icons.height,
                          isGender: false,
                          unit: "cm",
                            save: (v){
                            bmr.height = double.parse(v);
                            },
                          validator: (v){
                            if(v.toString().isEmpty){
                              return "Required";
                            }
                          }
                        ),
                        getItem(
                            title: "Weight",
                            iconDate: Icons.account_balance_wallet_outlined,
                            isGender: false,
                            unit: "kg",
                            save: (v){
                              bmr.weight = double.parse(v);
                            },
                            validator: (v){
                              if(v.toString().isEmpty){
                                return "Required";
                              }
                            }
                        ),
                        getItem(
                            title: "Age",
                            iconDate: Icons.calendar_month,
                            isGender: false,
                            unit: "year",
                            save: (v){
                              bmr.age = double.parse(v);
                            },
                            validator: (v){
                              if(v.toString().isEmpty){
                                return "Required";
                              }
                            }
                        ),
                      ],
                  )
                ),
              ),
              calculated ?
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10.sp
                    ),
                    child: Column(
                      children: [
                        Text(
                            "Your daily need of calories is :",
                          style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.w600,
                            fontSize: 22.sp
                          ),
                        ),
                        Text(
                            calculatedBMR.toInt().toString(),
                          style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w800,
                              fontSize: 22.sp,
                            color: green
                          ),
                        ),
                      ],
                    ),
                  ): Container(),
              SizedBox(height: 20.sp,),
              UserButton(
                  title: calculated ? "Continue" : "Calculate",
                  color: green,
                  method: (){
                    if(calculated == true){
                      Navigator.pop(context);
                    }else{
                      if(formKey.currentState?.validate() == true){
                        formKey.currentState?.save();
                        if(bmr.gen == gender.Female){
                          setState(() {
                            calculatedBMR = calcBMR.calcForWoman(bmr);
                          });
                        }
                        else{
                          setState(() {
                            calculatedBMR = calcBMR.calcForMan(bmr);
                          });
                        }
                        setState(() {
                          calculated = true;
                        });
                      }
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

  getItem({required String title , save , validator , unit ,required bool isGender , required iconDate}){
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.sp,
        vertical: 10.sp
      ),
      child: Row(
        children: [
          Container(
            width: UserResponsive.get(
                context: context,
                mobile: 50.sp,
                tablet: 30.sp
            ),
            height: UserResponsive.get(
                context: context,
                mobile: 50.sp,
                tablet: 30.sp
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular( UserResponsive.get(
                  context: context,
                  mobile: 15.sp,
                  tablet: 7.sp
              )),
              color: green,
            ),
            child: Icon(
              iconDate,
              color: Colors.white,
              size:  UserResponsive.get(
                  context: context,
                  mobile: 30.sp,
                  tablet: 15.sp
              ),
            ),
          ),
          const Spacer(),
          Text(
            title.toString() + " :",
            style: UserTheme.get(
                context: context,
                fontSize: UserResponsive.get(
                    context: context,
                    mobile: 15.sp,
                    tablet: 11.sp
                ),
                fontWight: FontWeight.w800,
                colorBright: black,
                colorDark: white
            ),
          ),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          isGender ?
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                        activeColor: green,
                        value: gender.Female,
                        groupValue: bmr.gen,
                        onChanged: (v){
                          setState(() {
                            bmr.gen = v!;
                            debugPrint(bmr.gen);
                          });
                        }
                    ),
                    Text(
                        "Female",
                      style: UserTheme.get(
                          context: context,
                          fontSize: UserResponsive.get(
                              context: context,
                              mobile:  13.sp,
                              tablet: 10.sp
                          ),
                          fontWight: FontWeight.w800,
                          colorBright: black,
                          colorDark: white
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        activeColor: green,
                        value: gender.Male,
                        groupValue: bmr.gen,
                        onChanged: (v){
                          setState(() {
                            bmr.gen = v;
                            debugPrint(bmr.gen);
                          });
                        }
                    ),
                    Text(
                        "Male",
                      style:UserTheme.get(
                          context: context,
                          fontSize: UserResponsive.get(
                              context: context,
                              mobile:  13.sp,
                              tablet: 10.sp
                          ),
                          fontWight: FontWeight.w800,
                          colorBright: black,
                          colorDark: white
                      ),
                    )
                  ],
                ),
              ],
            ),
          ) :
          Row(
            children: [
              Container(
                  width: UserResponsive.get(
                      context: context,
                      mobile: 50.sp,
                      tablet: 25.sp
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: 8.sp
                  ),
                  child: TextFormField(
                    onSaved: save,
                    validator: validator,
                    textAlignVertical: TextAlignVertical.center,
                    decoration : InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: green),
                      ),
                    ),
                  )
              ),
              Container(
                width: 30.sp,
                alignment: Alignment.centerLeft,
                child: Text(
                  unit.toString(),
                  style: UserTheme.get(
                      context: context,
                      fontSize: UserResponsive.get(
                          context: context,
                          mobile: 15.sp,
                          tablet: 11.sp
                      ),
                      fontWight: FontWeight.w800,
                      colorBright: black,
                      colorDark: white
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

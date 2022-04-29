import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Domain/DarkTheme.dart';
import '../Widgets/custom_appbar.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Provider.of<UserDarkTheme>(context).isDark? null  : background,
        body: Column(
          children: [
            getAppBar(
            context: context,
                perffix: const BackButton(),
                suffix: Container(width: 35.sp),
                title: "My Orders"
            ),
            Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: 400,
                    itemBuilder: (_ , index){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: (MediaQuery.of(context).size.width * (3/8)),
                        margin: EdgeInsets.symmetric(
                            vertical: 5.sp,
                            horizontal: 10.sp
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5.sp)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return  Image.asset(
                                        mixGrillPath,
                                        fit: BoxFit.fill,
                                        width: constraints.maxWidth,
                                        height: constraints.maxHeight,
                                      );
                                    }
                                )
                            ),
                            Expanded(
                                flex: 5,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return  Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp,
                                        ),
                                        color: Provider.of<UserDarkTheme>(context).isDark? Colors.grey.shade800  : white,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Mix Grill seafood",
                                                        style: UserTheme.get(
                                                            context: context,
                                                            fontSize: 15.sp,
                                                            fontWight: FontWeight.w700,
                                                            colorBright: black,
                                                            colorDark: white
                                                        ),
                                                      ),
                                                      Text(
                                                        "delivered",
                                                        style:  UserTheme.get(
                                                            context: context,
                                                            fontSize: 13.sp,
                                                            fontWight: FontWeight.w700,
                                                            colorBright: green,
                                                            colorDark: green
                                                        ),
                                                      ),
                                                      Text(
                                                        "15/8 03:20",
                                                        style: UserTheme.get(
                                                            context: context,
                                                            fontSize: 13.sp,
                                                            fontWight: FontWeight.w700,
                                                            colorBright: grey,
                                                            colorDark: grey
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: (){

                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: grey,
                                                    )
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: (){

                                                  },
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: (){},
                                                          icon: Icon(
                                                            Icons.refresh,
                                                            color: green,
                                                          )
                                                      ),
                                                      Text(
                                                        "Re-order",
                                                        style: UserTheme.get(
                                                            context: context,
                                                            fontSize: 14.sp,
                                                            fontWight: FontWeight.w800,
                                                            colorBright: green,
                                                            colorDark: green
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                )
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            )
          ],
        )
      ),
    );
  }
}

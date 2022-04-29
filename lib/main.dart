import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Domain/PlaceOrder/order_cubit.dart';
import 'package:restaurant_app/Domain/Product/product_cubit.dart';
import 'package:sizer/sizer.dart';
import 'Domain/AccountInfo/address_cubit.dart';
import 'Domain/AddToCard/card_cubit.dart';
import 'Domain/AddToFavorites/favorite_cubit.dart';
import 'Domain/AsyncCall.dart';
import 'Data/LocalStorage/db_helper_sharedPrefrences.dart';
import 'Domain/Auth/auth_cubit.dart';
import 'Domain/Auth/auth_state.dart';
import 'Domain/BlockObserver.dart';
import 'Domain/Categories/categories_cubit.dart';
import 'Domain/ChangeLanguage/language_cubit.dart';
import 'Domain/ChangeLanguage/language_state.dart';
import 'Domain/CheckConnection/connect_cubit.dart';
import 'Domain/CheckConnection/connect_state.dart';
import 'Domain/DarkTheme.dart';
import 'Domain/DisplayCard/display_card_cubit.dart';
import 'Domain/DisplayFavorite/display_favorite_cubit.dart';
import 'Domain/EmailVerfived/EmailCubit.dart';
import 'Domain/EmailVerfived/EmailStatus.dart';
import 'Domain/IncAndDecrementItem/inc_dec_item_cubit.dart';
import 'Domain/UserLocation/location_cubit.dart';
import 'Domain/UserLocation/location_statue.dart';
import 'Language/codegen_loader.g.dart';
import 'Presentation/Dialogs/no_internet_connection.dart';
import 'Presentation/Modules/introduction_screen.dart';
import 'Presentation/Modules/splach_screen.dart';
import 'app_route.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  BlocOverrides.runZoned(() {
     runApp(
        DevicePreview(
           enabled: false,//!kReleaseMode
           builder: (context)=> MultiProvider(
                    providers: [
                      BlocProvider (create: (_) => CheckConnectionCubit()..initialConnection()),
                      BlocProvider (create: (_) => ChangeLanguageCubit()),
                      BlocProvider (create: (_) => AuthCubit()),
                      BlocProvider (create: (_) => CategoryCubit()),
                      BlocProvider (create: (_) => ProductCubit()),
                      BlocProvider (create: (_) => FavoriteCubit()),
                      BlocProvider (create: (_) => CardCubit()),
                      BlocProvider(create:  (_) => DisplayFavoriteCubit()),//OrderCubit
                      BlocProvider(create:  (_) => OrderCubit()),
                      BlocProvider(create:  (_) => AddressCubit()),
                      BlocProvider(create:  (_) => IncDecItemCubit()),
                      BlocProvider (create: (_) => DisplayCardCubit()),
                      BlocProvider(create:  (_) => LocationCubit()),
                      BlocProvider(create:  (_) => EmailCubit()),
                      ChangeNotifierProvider(create: (_) => AsyncCall()),
                      ChangeNotifierProvider(create: (_) => UserDarkTheme()),

                    ],
                    child: EasyLocalization(
                        supportedLocales: const [Locale('en'), Locale('ar')],
                        saveLocale: true,
                        path: 'asset/Language', // <-- change the path of the translation files
                        fallbackLocale: const Locale('en'),
                        assetLoader: const CodegenLoader(),
                        child: const FoodApp()
                    )
                )
        )
     );
    },
    blocObserver: MyBlocObserver(),
  );

}
class FoodApp extends StatefulWidget {
  const FoodApp({Key? key}) : super(key: key);
  @override
  _FoodAppState createState() => _FoodAppState();
}
class _FoodAppState extends State<FoodApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return BlocListener<EmailCubit , EmailStatus>(
          listener: (context, state) {
            if( state is VerifiedSuccess ) {
              OneContext().popDialog(ShowCustomerDialog.context);
            }
            else if(state is VerifiedField){
              debugPrint("VerifiedField");
              OneContext().showDialog(
                builder: (context) {
                  ShowCustomerDialog.context = context;
                  return ShowCustomerDialog(
                      title : "Email not Verified",
                      subtitle: "Please check your email to verify Email .",
                      dismiss: false
                  ) ;
                });
            }
          },
          child: BlocBuilder<LocationCubit , LocationStatue>(
              builder: (context, state) {
                return BlocConsumer<AuthCubit , AuthStates>(
                  listener: ( context , state) {},
                  builder: (context , state){
                    return  BlocListener<CheckConnectionCubit , CheckConnectionState>(
                      listener: (BuildContext context, state) {
                        if( state is Connected ) {
                          OneContext().popDialog(ShowCustomerDialog.context);
                        }
                        else if(state is DisConnected){
                          OneContext().showDialog(
                            builder: (context ) {
                              ShowCustomerDialog.context = context;
                              return ShowCustomerDialog(
                                  title: "No Internet Connection.",
                                  subtitle: "Please check your internet connection and try again .",
                                  dismiss: false
                              );
                            }
                          );
                        }
                      },
                      child: BlocBuilder<ChangeLanguageCubit , ChangeLanguageState>(
                          builder: (context, state) {
                            return MaterialApp(
                              theme: ThemeData(
                                brightness: Provider.of<UserDarkTheme>(context).isDark ? Brightness.dark : Brightness.light
                              ),
                              supportedLocales: context.supportedLocales,
                              localizationsDelegates: context.localizationDelegates,
                              locale: context.locale,
                              useInheritedMediaQuery: true,
                              debugShowCheckedModeBanner: false,
                              onGenerateRoute : AppRoute.onGenerateRoute,
                              home: SplashScreen(nextScreen: const OnBoardingPage()),
                            );
                        }
                      ),
                    );
                  },
                );
              }
          ),
        );
      }
    );
  }
}

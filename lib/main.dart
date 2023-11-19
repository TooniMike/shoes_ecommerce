import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/cart_provider.dart';
import 'package:shoes/controllers/favorites_provider.dart';
import 'package:shoes/controllers/login_provider.dart';
import 'package:shoes/controllers/mainscreen_provider.dart';
import 'package:shoes/controllers/payment_controller.dart';
import 'package:shoes/controllers/product_provider.dart';
import 'views/ui/mainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
      ChangeNotifierProvider(create: (context) => ProductNotifier()),
      ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => LoginNotifier()),
      ChangeNotifierProvider(create: (context) => PaymentNotifier()),
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(325, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tooni',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFE2E2E2)
        ),
        home: MainScreen(),
      );}
    );
  }}

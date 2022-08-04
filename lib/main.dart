import 'package:flutter/material.dart';
import 'package:food_delivery/data/controllers/cart_controller.dart';
import 'package:food_delivery/data/controllers/popular_product_controller.dart';
import 'package:food_delivery/data/controllers/recommended_product_controller.dart';
import 'package:food_delivery/data/routes/route_helper.dart';
import 'package:get/get.dart';

import 'helper/dependencies.dart' as dependencies;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>()
        .getCartData(); //get cart data from local storage via shared prefs
    return GetBuilder<PopularProductController>(
      builder: (_) => GetBuilder<RecommendedProductController>(
        builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Food App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            //home: const SplashScreen(),
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        },
      ),
    );
  }
}

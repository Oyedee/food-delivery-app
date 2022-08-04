import 'package:food_delivery/pages/address/add_address_page.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = '/splash-page';
  static const String initialRoute = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String cartHistoryPage = '/cart-history-page';
  static const String signInPage = '/sign-in-page';
  static const String signUpPage = '/sign-up-page';
  static const String addAddressPage = '/add-address';

  static String getSplashPage() => splashPage;
  static String getInitialRoute() => initialRoute;

  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';

  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;
  static String getCartHistoryPage() => cartHistoryPage;
  static String getSignInPage() => signInPage;
  static String getSignUpPage() => signUpPage;
  static String getAddAddressPage() => addAddressPage;

  static List<GetPage> routes = [
    GetPage(
        name: splashPage,
        page: () => const SplashScreen(),
        transition: Transition.fadeIn),
    GetPage(name: initialRoute, page: () => const HomePage()),
    GetPage(
      name: signInPage,
      page: () => const SignInPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signUpPage,
      page: () => const SignUpPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(
          pageId: int.parse(pageId!),
          page: page!,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(
          pageId: int.parse(pageId!),
          page: page!,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () => const CartPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartHistoryPage,
      page: () => const CartHistoryPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: addAddressPage,
      page: () => const AddAddressPage(),
      transition: Transition.fadeIn,
    ),
  ];
}

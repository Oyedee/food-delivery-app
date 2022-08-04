import 'dart:convert';

import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    //used to reset the contents of the shared preferences
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY);

    var time = DateTime.now().toString();
    cart = []; //initialize cart to be empty

    //convert cart objects to string
    cartList.forEach((element) {
      element.time = time;
      cart.add(jsonEncode(element.toJson()));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
  }

  List<CartModel> getCartList() {
    cart = [];
    if (sharedPreferences.getStringList(AppConstants.CART_LIST) != null) {
      cart = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }

    List<CartModel> cartList = [];
    cart.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  //clear cart and add items to cart history
  void addToCartHistoryList(List<CartModel> cartList) {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }

    cart = []; //initialize cart to be empty
    //convert cart objects to string
    cartList.forEach((element) {
      cart.add(jsonEncode(element.toJson()));
    });
    print('cart items: $cart');
    //add items to cart history after checkout
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    print('cart history: $cartHistory');
    //clear cart after checkout
    removeCart();
    //save cart history to shared preferences
    sharedPreferences.setStringList(AppConstants.CART_HISTORY, cartHistory);
  }

  //get cart history
  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.getStringList(AppConstants.CART_HISTORY) != null) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }
    List<CartModel> cartHistoryList = [];
    cartHistory.forEach((element) =>
        cartHistoryList.add(CartModel.fromJson(jsonDecode(element))));
    return cartHistoryList;
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY);
  }
}

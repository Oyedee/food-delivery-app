import 'package:flutter/material.dart';
import 'package:food_delivery/data/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cartController;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      //print('number of items in cart: $_quantity');
    } else {
      _quantity = checkQuantity(_quantity - 1);
      //print('number of items in cart: $_quantity');
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        'Item count',
        'You can not have negative item count!',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 900),
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) >= 20) {
      Get.snackbar(
        'Item count',
        'You can not have more than 20 item count!',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 900),
      );
      return 20;
    } else {
      return quantity;
    }
  }

  //initialize the current product item when you navigate to the popularProduct page
  //which is after a product item is selected from the popularProduct list.
  //also initialize the cart controller to be used to retrieve the quantity of the product items in the cart
  //and also check if a product already exist in the cart
  void initProduct(ProductModel product, CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;

    //handle the case when the product is already in cart
    var exist = false;
    exist = _cartController.existInCart(product);
    //check if it exists in the cart and if it does, then retrieve the quantity
    //and set it to the item quantity in cart
    if (exist) {
      _inCartItems = _cartController.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    _cartController.addItem(product, _quantity);
    _quantity = 0;
    //get the quantity of items in the cart
    _inCartItems = _cartController.getQuantity(product);
    update();
  }

  //get the total items in the cart and set it to the cart icon
  int get totalItems => _cartController.totalItems;

  //get the list of item in the cart
  List<CartModel> get getItems => _cartController.getItems;
}

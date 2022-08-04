class AppConstants {
  static const String APP_NAME = 'LagosChow';
  static const int APP_VERSION = 1;

  static const String BASE_URL = 'http://mvs.bslmeiyu.com';
  //static const String BASE_URL = 'http://127.0.0.1:8000';
  static const String POPULAR_PRODUCT_URI = '/api/v1/products/popular';
  static const String RECOMMENDED_PRODUCT_URI = '/api/v1/products/recommended';
  static const String DRINKS_URI = '/api/v1/products/drinks';
  static const String UPLOAD_URL = '/uploads/';

  //auth end points
  static const String REGISTRATION_URI = '/api/v1/auth/register';
  static const String LOGIN_URI = '/api/v1/auth/login';
  static const String USER_INFO_URI = '/api/v1/customer/info';
  static const String TOKEN = 'token';

  //shared preferences constants
  static const String CART_LIST = 'cartList';
  static const String CART_HISTORY = 'cart-history-list';
  static const String USER_NUMBER = 'user-number';
  static const String USER_PASSWORD = 'user-password';

  //google maps
  static const String GEOCODE_URI = '/api/v1/config/geocode-api';
  static const String USER_ADDRESS = 'user-address';
  static const String ADD_USER_ADDRESS = '/api/v1/customer/address/add';
  static const String ADDRESS_LIST_URI = '/api/v1/customer/address/list';
}

//http://mvs.bslmeiyu.com/api/v1/auth/register

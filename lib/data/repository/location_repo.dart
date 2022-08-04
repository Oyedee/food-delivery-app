import 'package:food_delivery/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/address_model.dart';
import '../../utils/app_constants.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressFromPosition(LatLng position) async {
    return await apiClient.getData(
        '${AppConstants.GEOCODE_URI}?lat=${position.latitude}&lng=${position.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? '';
  }

  //save user address
  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(
        AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  //get user address list
  Future<Response> getAddressList() async {
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }
}

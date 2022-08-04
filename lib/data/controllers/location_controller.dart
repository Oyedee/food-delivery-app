import 'dart:convert';

import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../repository/location_repo.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late Position _position;
  Position get position => _position;

  late Position _pickPosition;
  Position get pickPosition => _pickPosition;

  Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;

  Placemark _pickPlacemark = Placemark();
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  List<AddressModel> _allAddressList = [];
  List<AddressModel> get allAddressList => _allAddressList;

  List<String> _addressTypeList = ['Home', 'Office', 'Others'];
  List<String> get addressTypeList => _addressTypeList;

  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  late GoogleMapController _googleMapController;
  GoogleMapController get googleMapController => _googleMapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  void setMapController(GoogleMapController controller) {
    _googleMapController = controller;
  }

  void updatePosition(CameraPosition cameraPosition, bool fromAddress) async {
    if (_updateAddressData) {
      _isLoading = true;
      update();
      try {
        if (_updateAddressData) {
          _position = Position(
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        }

        //get address from position
        if (_changeAddress) {
          //grab address from the geocode location api via backend(google)
          String _address = await getAddressFromPosition(LatLng(
              cameraPosition.target.latitude, cameraPosition.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressFromPosition(LatLng position) async {
    String _address = 'Unknown Location Found';
    Response response = await locationRepo.getAddressFromPosition(position);
    if (response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
      print(_address);
    } else {
      _address = 'Unknown Location Found';
    }
    return _address;
  }

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    //converting the address to map using json decode.
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  //set address type index if address is home, office or others
  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _isLoading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      String message = response.body['message'];
      responseModel = ResponseModel(true, message);
      //save user address to local storage
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //get all address from the backend
  Future<void> getAddressList() async {
    Response response = await locationRepo.getAddressList();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }
}

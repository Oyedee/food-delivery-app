import 'package:flutter/material.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/data/controllers/auth_controller.dart';
import 'package:food_delivery/data/controllers/location_controller.dart';
import 'package:food_delivery/data/controllers/user_controller.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonNameController =
      TextEditingController();
  final TextEditingController _contactPersonNumberController =
      TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(36.8189700, 10.1657900),
    zoom: 17,
  );
  late LatLng _initialPosition = const LatLng(36.8189700, 10.1657900);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().isUserLoggedIn();
    //if user is logged in and user info is empty, get user info
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      //this will be the actual position of the user
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']),
        ),
        zoom: 17,
      );
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        if (userController.userModel != null &&
            _contactPersonNameController.text.isEmpty) {
          _contactPersonNameController.text = userController.userModel.name;
          _contactPersonNumberController.text = userController.userModel.phone;

          if (Get.find<LocationController>().addressList.isNotEmpty) {
            _addressController.text =
                Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController) {
          _addressController.text =
              '${locationController.placemark.name ?? ''} '
              '${locationController.placemark.locality ?? ''} '
              '${locationController.placemark.postalCode ?? ''} '
              '${locationController.placemark.country ?? ''}';
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //google maps
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 2, color: AppColors.mainColor)),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition,
                          zoom: 17,
                        ),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        onCameraIdle: () {
                          locationController.updatePosition(
                              _cameraPosition, true);
                        },
                        onCameraMove: (position) {
                          _cameraPosition = position;
                        },
                        onMapCreated: (GoogleMapController controller) {
                          locationController.setMapController(controller);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                //address type icons
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width30),
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: locationController.addressTypeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              //update the address type index
                              locationController.setAddressTypeIndex(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width20,
                                  vertical: Dimensions.height10),
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context).cardColor),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200]!,
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Icon(
                                index == 0
                                    ? Icons.home_filled
                                    : index == 1
                                        ? Icons.work
                                        : Icons.location_on,
                                color:
                                    index == locationController.addressTypeIndex
                                        ? AppColors.mainColor
                                        : Theme.of(context).disabledColor,
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                //delivery address
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  child: BigText(text: 'Delivery address'),
                ),
                SizedBox(height: Dimensions.height20),
                //address
                AppTextField(
                    textController: _addressController,
                    hintText: 'Your address',
                    icon: Icons.map),
                SizedBox(height: Dimensions.height20),
                //contact person name
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  child: BigText(text: 'Contact Name'),
                ),

                SizedBox(height: Dimensions.height20),
                //contact person name
                AppTextField(
                    textController: _contactPersonNameController,
                    hintText: 'Your name',
                    icon: Icons.person),
                SizedBox(height: Dimensions.height20),
                //contact person number
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  child: BigText(text: 'Phone Number'),
                ),
                SizedBox(height: Dimensions.height20),
                //contact person number
                AppTextField(
                    textController: _contactPersonNumberController,
                    hintText: 'Your number',
                    icon: Icons.phone),
                SizedBox(height: Dimensions.height20),
              ],
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.height20 * 8,
                padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  right: Dimensions.width30,
                  left: Dimensions.width30,
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.deferToChild,
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          contactPersonName: _contactPersonNameController.text,
                          contactPersonNumber:
                              _contactPersonNumberController.text,
                          address: _addressController.text,
                          addressType: locationController.addressTypeList[
                              locationController.addressTypeIndex],
                          latitude:
                              locationController.position.latitude.toString(),
                          longitude:
                              locationController.position.longitude.toString(),
                        );
                        locationController
                            .addAddress(_addressModel)
                            .then((response) {
                          if (response.isSuccess) {
                            Get.back();
                            Get.snackbar('Address', 'Added Successfully');
                          } else {
                            showCustomSnackBar('Address',
                                title: 'Could not save address');
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        child: BigText(
                          text: 'Save Address',
                          color: Colors.white,
                          size: 23,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

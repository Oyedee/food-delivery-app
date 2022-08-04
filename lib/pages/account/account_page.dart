import 'package:flutter/material.dart';
import 'package:food_delivery/data/controllers/auth_controller.dart';
import 'package:food_delivery/data/controllers/cart_controller.dart';
import 'package:food_delivery/data/controllers/user_controller.dart';
import 'package:food_delivery/data/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    //get user info if user is logged in
    if (_isUserLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          size: 24,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _isUserLoggedIn
              ? (userController.isLoading
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: Column(children: [
                        //profile icon
                        AppIcon(
                          icon: Icons.person,
                          size: Dimensions.height15 * 10,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height45 + Dimensions.height30,
                        ),
                        SizedBox(height: Dimensions.height30),
                        Expanded(
                          //always wrap a singleChildScrollView with Expanded widget
                          child: SingleChildScrollView(
                            child: Column(children: [
                              //user name
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.person,
                                  size: Dimensions.height10 * 5,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                ),
                                bigText: BigText(
                                  text: userController.userModel.name,
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              //email
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.email,
                                  size: Dimensions.height10 * 5,
                                  backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                ),
                                bigText: BigText(
                                  text: userController.userModel.email,
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              //phone
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.phone,
                                  size: Dimensions.height10 * 5,
                                  backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                ),
                                bigText: BigText(
                                  text: userController.userModel.phone,
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              //address
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.location_on,
                                  size: Dimensions.height10 * 5,
                                  backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                ),
                                bigText: BigText(
                                  text: 'ParkView, New York',
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              //message
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.message,
                                  size: Dimensions.height10 * 5,
                                  backgroundColor: Colors.redAccent,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                ),
                                bigText: BigText(
                                  text: 'Messages',
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .isUserLoggedIn()) {
                                    Get.find<AuthController>().clearUserData();
                                    Get.find<CartController>().clear();
                                    Get.find<CartController>()
                                        .clearCartHistory();
                                    Get.offNamed(RouteHelper.getSignInPage());
                                  }
                                },
                                child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.logout,
                                    size: Dimensions.height10 * 5,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                  ),
                                  bigText: BigText(
                                    text: 'Logout',
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                            ]),
                          ),
                        )
                      ]),
                    )
                  : const Center(child: CircularProgressIndicator()))
              : Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 10,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/image/signintocontinue.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 4,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Center(
                              child: BigText(
                                text: 'Sign in to Continue',
                                color: Colors.white,
                                size: Dimensions.font20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

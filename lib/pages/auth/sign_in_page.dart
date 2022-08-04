import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/data/controllers/auth_controller.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../data/routes/route_helper.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    //sign in
    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar('Type in your email address',
            title: 'Email address');
      } else if (password.isEmpty) {
        showCustomSnackBar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password must be at least 6 characters',
            title: 'Password');
      } else {
        //sign in user
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitialRoute());
          } else {
            showCustomSnackBar(status.message);

            print(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.25,
                        child: const Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage:
                                AssetImage('assets/image/logo part 1.png'),
                          ),
                        ),
                      ),
                      //welcome
                      Container(
                          margin: EdgeInsets.only(left: Dimensions.height20),
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                    fontSize: Dimensions.font20 * 3,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: Dimensions.height10),
                              BigText(
                                text: 'Sign into your account',
                                color: Colors.grey[400],
                                size: Dimensions.font20,
                              ),
                            ],
                          )),
                      SizedBox(height: Dimensions.height10),
                      //email
                      AppTextField(
                        textController: emailController,
                        hintText: 'Email',
                        icon: Icons.email,
                      ),
                      SizedBox(height: Dimensions.height30),
                      //password
                      AppTextField(
                        textController: passwordController,
                        hintText: 'Password',
                        icon: Icons.lock,
                        isObscure: true,
                      ),
                      SizedBox(height: Dimensions.height20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(child: Container()),
                          RichText(
                            //for links and hyperlinks
                            text: TextSpan(
                              text: 'Sign into your account',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font16,
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.width30)
                        ],
                      ),
                      SizedBox(height: Dimensions.height30),
                      //sign in button
                      GestureDetector(
                        onTap: () => _login(authController),
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                          ),
                          child: Center(
                            child: BigText(
                              text: 'Sign in',
                              size: Dimensions.font20 * 1.3,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      RichText(
                        //for links and hyperlinks
                        text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => const SignUpPage(),
                                      transition: Transition.fade);
                                },
                              text: 'Create',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainBlackColor,
                                fontSize: Dimensions.font20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

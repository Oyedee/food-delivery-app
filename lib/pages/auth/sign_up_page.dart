import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../data/controllers/auth_controller.dart';
import '../../data/routes/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      't.png',
      'f.png',
      'g.png',
    ];
    //sign up registration
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar('Type in your name', title: 'Name');
      } else if (phone.isEmpty) {
        showCustomSnackBar('Type in your phone number', title: 'Phone number');
      } else if (email.isEmpty) {
        showCustomSnackBar('Type in your email address',
            title: 'Email address');
      } /*else if (GetUtils.isEmail(email)) {
        showCustomSnackBar('Type in a valid email address',
            title: 'Valid email address');
      }*/
      else if (password.isEmpty) {
        showCustomSnackBar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password must be at least 6 characters',
            title: 'Password');
      } else {
        showCustomSnackBar('All went well', title: 'Perfect!!');
        SignUpBody signUpBody = SignUpBody(
          name: name,
          email: email,
          password: password,
          phone: phone,
        );

        //register user
        authController.registration(signUpBody).then((status) {
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
        builder: (_authController) {
          //if isLoading is true show circular progress bar
          //else show sign up page
          //isLoading is false by default
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      Container(
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
                      SizedBox(height: Dimensions.height30),
                      //name
                      AppTextField(
                        textController: nameController,
                        hintText: 'Name',
                        icon: Icons.person,
                      ),
                      SizedBox(height: Dimensions.height30),
                      //phone
                      AppTextField(
                        textController: phoneController,
                        hintText: 'Phone',
                        icon: Icons.phone,
                      ),
                      SizedBox(height: Dimensions.height30),

                      //sign up button
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
                        },
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
                              text: 'Sign up',
                              size: Dimensions.font20 * 1.3,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      RichText(
                        //for links and hyperlinks
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                            },
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      RichText(
                        //for links and hyperlinks
                        text: TextSpan(
                          text: 'Sign up using one of the following platforms',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16 * 0.7,
                          ),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: Dimensions.radius30,
                              backgroundImage: AssetImage(
                                  'assets/image/' + signUpImages[index]),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

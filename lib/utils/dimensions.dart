import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //scaling factors
  static double scalingFactorPageView = screenHeight / 220;
  static double scalingFactorPageViewParentContainer = screenHeight / 320;
  static double scalingFactorTextContainer = screenHeight / 120;
  static double scalingFactorHeight10 = screenHeight / 10;
  static double scalingFactorHeight20 = screenHeight / 20;
  static double scalingFactorHeight24 = screenHeight / 24;
  static double scalingFactorHeight15 = screenHeight / 15;
  static double scalingFactorHeight30 = screenHeight / 30;
  static double scalingFactorHeight45 = screenHeight / 45;

  //pageView container height
  static double pageViewContainer = screenHeight / scalingFactorPageView;
  static double pageViewParentContainer =
      screenHeight / scalingFactorPageViewParentContainer;
  static double pageViewTextContainer =
      screenHeight / scalingFactorTextContainer;

  //dynamic height padding and margin
  static double height10 = screenHeight / scalingFactorHeight10;
  static double height15 = screenHeight / scalingFactorHeight15;
  static double height20 = screenHeight / scalingFactorHeight20;
  static double height24 = screenHeight / scalingFactorHeight24;
  static double height30 = screenHeight / scalingFactorHeight30;
  static double height45 = screenHeight / scalingFactorHeight45;

  //dynamic width padding and margin
  static double width10 = screenWidth / scalingFactorHeight10;
  static double width15 = screenWidth / scalingFactorHeight15;
  static double width20 = screenWidth / scalingFactorHeight20;
  static double width30 = screenWidth / scalingFactorHeight30;

  //fonts
  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / scalingFactorHeight20;
  static double font26 = screenHeight / 32.46;

  //radius
  static double radius20 = screenHeight / scalingFactorHeight20;
  static double radius15 = screenHeight / scalingFactorHeight15;
  static double radius30 = screenHeight / scalingFactorHeight30;

  //icon size
  static double iconSize24 = screenHeight / scalingFactorHeight24;
  static double iconSize16 = screenHeight / 52.75;

  //listView Size
  static double listViewImg = screenWidth / 3.25;
  static double listViewTextContainer = screenWidth / 3.9;

  //popular food
  static double popularFoodImgSize = screenHeight / 2.41;

  //bottomNavigationBar height
  static double bottomHeightBar = screenHeight / 7.03;

  //splash screen dimensions
  static double splashImageHeight = screenHeight / 3.38;
}

import 'package:food_delivery/data/repository/user_repo.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:get/get.dart';

import '../../models/response_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  //check if registration is loading
  bool _isLoading = false;
  late UserModel _userModel = UserModel(
    id: 1,
    name: 'John Doe',
    email: 'johnDoe@gmail.com',
    phone: '+92333456789',
    orderCount: 0,
  );

  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;

  //get user info
  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print('response.body: ${response.body}');
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, 'Success');
    } else {
      //error
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}

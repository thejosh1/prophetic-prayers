
import 'package:get/get.dart';
import 'package:prophetic_prayers/controller/auth_controllers/auth_controller.dart';

import '../controller/user_controllers/user_controller.dart';
import '../data/repositories/auth_repositories/auth_repo.dart';
import '../data/repositories/user_repositories/user_repo.dart';

Future<void> init() async {

  //auth repo
  Get.lazyPut(() => AuthRepo());
  //user repo
  Get.lazyPut(() => UserRepo(authController: Get.find()));

  //user controller
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  //auth Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));


}
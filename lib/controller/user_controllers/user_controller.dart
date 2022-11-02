import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../data/repositories/user_repositories/user_repo.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  Future<DocumentSnapshot<Object?>> getUserRoute() async {
    return await userRepo.getUserRoute();
  }

 Future<void> changeProfilePicture(String imagePath) async {
   return await userRepo.changeProfilePicture(imagePath);
 }

 Future<void> editName(String name) async {
    return await userRepo.editName(name);
 }

 Future<void> editEmail(String email, String password) async {
    return await userRepo.editEmail(email, password);
 }

}
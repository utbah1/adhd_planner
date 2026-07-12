import 'package:get/get.dart';

import '../data/models/user_model.dart';

class UserController extends GetxController {
  final Rxn<UserModel> user =
      Rxn<UserModel>();

  UserModel? get currentUser =>
      user.value;

  bool get hasUser =>
      user.value != null;

  void setUser(
    UserModel value,
  ) {
    user.value = value;
  }

  void clearUser() {
    user.value = null;
  }
}
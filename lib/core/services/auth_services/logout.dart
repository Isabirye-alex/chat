import 'package:chat_app/core/services/auth_services/auth_repository.dart';
import 'package:get/get.dart';
import 'package:chat_app/core/services/auth_services/login/login_screen.dart';

class LogoutController extends GetxController {
  static LogoutController get instance => Get.find();
  final AuthRepository _authRepo = AuthRepository();

  final RxBool isLoading = false.obs;

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _authRepo.logOut();
      Get.offAll(() => LoginScreen()); 
    } catch (e) {
      Get.snackbar('Logout Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

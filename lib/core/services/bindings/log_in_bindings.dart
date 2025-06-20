import 'package:chat_app/core/services/auth_services/login/login_controller.dart';
import 'package:get/get.dart';

class LogInBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

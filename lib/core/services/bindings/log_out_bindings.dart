import 'package:chat_app/core/services/auth_services/logout.dart';
import 'package:get/get.dart';

class LogOutBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogoutController());
  }
}

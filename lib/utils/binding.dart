import 'package:get/get.dart';
import '../controller/admin_controller.dart';
import '../controller/user_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminController(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}

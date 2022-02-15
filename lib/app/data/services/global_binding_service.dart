import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:contack_and_note/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(UserController());
  }
}
import 'package:contack_and_note/app/controllers/contact_controller.dart';
import 'package:contack_and_note/app/controllers/note_controller.dart';
import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:contack_and_note/app/controllers/home_controller.dart';
import 'package:get/get.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(UserController());
    Get.put(NoteController());
    Get.put(ContactController());
  }
}
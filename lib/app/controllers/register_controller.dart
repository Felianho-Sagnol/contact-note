import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();
  var counter = 0.obs;
  var isLoading = false.obs;
  void increment() {
    counter++;
    update();
  }

  void setIsLoading(var isLoading) {
    this.isLoading = isLoading;
    update();
  }
}

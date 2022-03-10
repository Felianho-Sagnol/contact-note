import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var counter = 0.obs;
  void increment() {
    
    counter++;
    //update(); 
    print(counter.toString());
  }
}
import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IsAuthenticatedMidleware extends GetMiddleware {
  @override
  int get priority => 5;

  @override
  RouteSettings? redirect(String? route) {
    
    if(UserController.to.isAuthenticated()){
      print('Redirecting to home');
      return RouteSettings(name: '/');
    }
    print('Redirecting to anywher from intern');
    return null;
  }
}
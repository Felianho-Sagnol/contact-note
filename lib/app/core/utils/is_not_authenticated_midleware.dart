import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IsNotAuthenticatedMidleware extends GetMiddleware {
  @override
  int get priority => 4;

  @override
  RouteSettings? redirect(String? route) {
    if(!UserController.to.isAuthenticated()){
      return RouteSettings(name: '/login');
    }
    return null;
  }
}
import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:contack_and_note/app/data/services/auth_service.dart';
import 'package:contack_and_note/app/global_widgets/drawer_menu.dart';
import 'package:contack_and_note/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        drawer: MenuDrawer(),
          appBar: AppBar(
            title: Text("Contacts & Notes"),
            actions: [
              IconButton(
                onPressed: (){
                  Get.toNamed('/login');
                },
                icon: Icon(
                  Icons.person_add_alt_1_rounded,
                  color:Colors.white,
                ),
              )
            ],
          ),
          body: Text('heee'),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await authService.logOut();
              Get.offAllNamed('/login');
              HomeController.to.increment();

            }, // This is incredibly simple!
            child: Container(
              child: Obx(
                () => Text(HomeController.to.counter.toString(),
                    style: const TextStyle(fontSize: 20.0)),
              ),
            ),
          )),
    );
  }
}

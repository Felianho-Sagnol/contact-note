import 'package:contack_and_note/app/data/models/contact_model.dart';
import 'package:contack_and_note/app/global_widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contact extends StatelessWidget {
  Contact({Key? key}) : super(key: key);
  ContactModel? contact;
  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      if (Get.arguments['contact'] != null) {
        contact = Get.arguments['contact'];
      }
    }
    return SafeArea(
      child: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          elevation: 0.5,
          title: Text(
            contact!.fullName,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}

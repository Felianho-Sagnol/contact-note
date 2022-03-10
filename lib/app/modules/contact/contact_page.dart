import 'dart:math';

import 'package:contack_and_note/app/controllers/contact_controller.dart';
import 'package:contack_and_note/app/core/values/colors.dart';
import 'package:contack_and_note/app/global_widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contact extends StatelessWidget {
  Contact({Key? key}) : super(key: key);

  var colors = listColors;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(title: Text("My Contacts")),
        body: ContactController.to.contacts.length == 0
            ? Text("vide")
            : ListView.builder(
                itemBuilder: (BuildContext, index) {
                  var contact = ContactController.to.contacts[index];
                  var length = contact.fullName.toString().length;
                  var subtitle = contact.phone.toString();
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.offNamed("/add-contact",
                            arguments: {'contact': contact});
                      },
                      leading: CircleAvatar(
                          backgroundColor : colors[random.nextInt(6)],
                          child: Text(
                              contact.fullName[0].toString().toUpperCase())),
                      title: Text(contact.fullName.toString()),
                      subtitle: Text(subtitle),
                    ),
                  );
                },
                itemCount: ContactController.to.contacts.length,
                shrinkWrap: true,
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
              ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Get.offNamed('/add-contact');
          },
        ),
      ),
    );
  }
}

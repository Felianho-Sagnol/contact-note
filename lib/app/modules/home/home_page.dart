import 'dart:math';

import 'package:contack_and_note/app/controllers/contact_controller.dart';
import 'package:contack_and_note/app/controllers/note_controller.dart';
import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:contack_and_note/app/core/values/colors.dart';
import 'package:contack_and_note/app/data/models/contact_model.dart';
import 'package:contack_and_note/app/data/models/note_model.dart';
import 'package:contack_and_note/app/data/services/auth_service.dart';
import 'package:contack_and_note/app/global_widgets/drawer_menu.dart';
import 'package:contack_and_note/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  AuthService authService = AuthService();

  var firstNotes = <NoteModel>[];
  var firstContacts = <ContactModel>[];

  var colors = listColors;
  Random random = Random();

  void setFirstContacts() {
    var f_firstContacts = <ContactModel>[];
    for (var i = 0; i < ContactController.to.contacts.length; i++) {
      if (i == 2) break;
      f_firstContacts.add(ContactController.to.contacts[i]);
    }

    firstContacts.assignAll(f_firstContacts);
  }

  void setFirstNotes() {
    var f_firstNotes = <NoteModel>[];
    for (var i = 0; i < NoteController.to.notes.length; i++) {
      if (i == 2) break;
      f_firstNotes.add(NoteController.to.notes[i]);
    }

    firstNotes.assignAll(f_firstNotes);
  }

  @override
  Widget build(BuildContext context) {
    setFirstContacts();
    setFirstNotes();
    return SafeArea(
      child: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          elevation: 0.5,
          title: Text(
            "Contacts & Notes",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                //await this.authService.logOut();
                Get.defaultDialog(
                  title: "Log out",
                  content: Text("Are you sur to logout ?"),
                  barrierDismissible: false,
                  confirm: ElevatedButton(
                    child: Text("YES"),
                    onPressed: () async {
                      Get.back();
                      await this.authService.logOut();
                    },
                  ),
                  cancel: ElevatedButton(
                    child: Text("No"),
                    onPressed: () {
                      Get.back();
                      //Navigator.of(context).pop();
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    child: InkWell(
                      onTap: () {
                        Get.offNamed('/add-contact');
                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 5),
                          Obx(
                            () => Text(
                              ContactController.to.contactsLength.value
                                  .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ), // icon
                          SizedBox(height: 5),
                          Text(
                            "Contacts",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.blue,
                            ),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 100,
                    child: InkWell(
                      splashColor: Colors.green, // splash color
                      onTap: () {
                        Get.offNamed('/add-note');
                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 5),
                          Obx(
                            () => Text(
                              NoteController.to.notesLength.value.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Notes",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

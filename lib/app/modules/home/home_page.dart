import 'dart:math';

import 'package:contack_and_note/app/controllers/contact_controller.dart';
import 'package:contack_and_note/app/controllers/note_controller.dart';
import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:contack_and_note/app/core/values/colors.dart';
import 'package:contack_and_note/app/data/services/auth_service.dart';
import 'package:contack_and_note/app/global_widgets/drawer_menu.dart';
import 'package:contack_and_note/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  AuthService authService = AuthService();

  var firstConttacts = ContactController.to.getFirstContacts();
  var firstNotes = NoteController.to.getFirstNotes();

  var colors = listColors;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    print(firstNotes);
    return SafeArea(
      child: Scaffold(
          drawer: MenuDrawer(),
          appBar: AppBar(
            elevation: 0.5,
            title: Text("Contacts & Notes"),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                icon: Icon(
                  Icons.person_add_alt_1_rounded,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body:
            SingleChildScrollView(
              child: Column(
                children: [
                  Text('hello'),
                  ListView.builder(
                    itemBuilder: (BuildContext, index) {
                      var contact = firstConttacts[index];
                      var length = contact.fullName.toString().length;
                      var subtitle = contact.phone.toString();
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Get.offNamed("/add-contact",
                                arguments: {'contact': contact});
                          },
                          leading: CircleAvatar(
                              backgroundColor: colors[random.nextInt(6)],
                              child: Text(contact.fullName[0]
                                  .toString()
                                  .toUpperCase())),
                          title: Text(contact.fullName.toString()),
                          subtitle: Text(subtitle),
                        ),
                      );
                    },
                    itemCount: firstConttacts.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    itemBuilder: (BuildContext, index) {
                      var size = 35;
                      var note = firstNotes[index];
                      var length = note.title.toString().length;
                      var end = length > size ? size : length;
                      var subtitle = end == length
                          ? note.content.toString()
                          : note.content.toString().substring(0, end) + "...";
                      return Card(
                        child: ListTile(
                          onTap: () {
                            print(note);
                            Get.offNamed("/add-note",
                                arguments: {'note': note});
                          },
                          leading: CircleAvatar(
                              backgroundColor: colors[random.nextInt(6)],
                              child:
                                  Text(note.title[0].toString().toUpperCase())),
                          title: Text(note.title.toString()),
                          subtitle: Text(subtitle),
                        ),
                      );
                    },
                    itemCount: firstNotes.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                  ),
                ],
              ),
            )
          ,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await authService.logOut();
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

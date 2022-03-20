import 'package:contack_and_note/app/data/models/note_model.dart';
import 'package:contack_and_note/app/global_widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Note extends StatelessWidget {
  Note({Key? key}) : super(key: key);
  NoteModel? note;
  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      if (Get.arguments['note'] != null) {
        note = Get.arguments['note'];
      }
    }
    return SafeArea(
      child: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          elevation: 0.5,
          title: Text(
            note!.title,
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

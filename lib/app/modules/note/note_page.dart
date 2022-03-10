import 'dart:math';

import 'package:contack_and_note/app/controllers/note_controller.dart';
import 'package:contack_and_note/app/core/values/colors.dart';
import 'package:contack_and_note/app/global_widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Note extends StatelessWidget {
  Note({Key? key}) : super(key: key);

  var colors = listColors;
  Random random = Random();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(title: Text("My notes")),
        body: ListView.builder(
        itemBuilder: (BuildContext, index){
          var size = 35;
          var note = NoteController.to.notes[index];
          var length = note.title.toString().length;
          var end = length > size ? size: length;
          var subtitle = end == length ? note.content.toString() : note.content.toString().substring(0,end) + "...";
          return Card(
            child: ListTile(
              onTap: (){
                print(note);
                Get.offNamed("/add-note", arguments: {'note' :note});
              },
              leading: CircleAvatar(
                backgroundColor : colors[random.nextInt(6)],
                child : Text(note.title[0].toString().toUpperCase())
              ),
              title: Text(note.title.toString()),
              subtitle: Text(
                subtitle
              ),
            ),
          );
        },
        itemCount: NoteController.to.notes.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Get.offNamed('/add-note');
          },
        ),
      ),
    );
  }
}

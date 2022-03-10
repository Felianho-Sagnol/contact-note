import 'package:contack_and_note/app/core/themes/theme_helper.dart';
import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:contack_and_note/app/data/models/note_model.dart';
import 'package:contack_and_note/app/data/models/note_model.dart';
import 'package:contack_and_note/app/data/services/firestore_note_service.dart';
import 'package:contack_and_note/app/global_widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddNote extends StatelessWidget {
  AddNote({Key? key}) : super(key: key);

  bool addNewNote = true;
  NoteModel? note;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleControler = new TextEditingController();
  final TextEditingController contentControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      if (Get.arguments['note'] != null) {
        addNewNote = false;
        note = Get.arguments['note'];
        titleControler.text = note!.title.toString();
        contentControler.text = note!.content.toString();
      }
    }
    var addText = addNewNote? "Add a new note" : "Update the note";
    return SafeArea(
      child: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          title: addNewNote? Text("Add new note") : Text("Update the note"),
          elevation: 0.5,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              FirestoreNoteService noteService = FirestoreNoteService();
              var now = DateTime.now();
              var formatter = DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(now);
              if(addNewNote){
                NoteModel newNote = NoteModel(
                  userUid: UserController.to.user().uid,
                  title: titleControler.text,
                  content: contentControler.text,
                  createdAt: formattedDate,
                  updatedAt: formattedDate);
                  await noteService.add(newNote);
              }else{
                var title = note!.title;
                if(note != null){
                  note?.update(titleControler.text,contentControler.text,formattedDate);
                }
                await noteService.update(title,note!);
              }
            }
          },
          child: Text('Save'),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            //decoration: BoxDecoration(color: Colors.red),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  addText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 35),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          controller: titleControler,
                          decoration: ThemeHelper().textInputDecoration(
                            'Title',
                            'Enter the title',
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the title";
                            }
                            return null;
                          },
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      SizedBox(height: 35),
                      TextFormField(
                        controller: contentControler,
                        minLines: 10,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          //labelText: "Content",
                          hintText: "Enter the content",
                          labelText: "Content",
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          labelStyle: TextStyle(color: Colors.grey),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "The Content must'nt be empty";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

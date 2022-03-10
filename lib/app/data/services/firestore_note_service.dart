import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contack_and_note/app/controllers/note_controller.dart';
import 'package:contack_and_note/app/data/models/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirestoreNoteService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('notes');

  Future<void> add(NoteModel noteModel) async {
    await _collection
        .add(noteModel.toMap())
        .then((doc) => {
              _collection.doc(doc.id).update({'id': doc.id}),
              NoteController.to
                  .setNotes()
                  .then((_) => {Get.offAllNamed('/notes')}),
              Get.snackbar(
                "Add Success",
                noteModel.title + " has been added successfully",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                duration: Duration(seconds: 5),
                isDismissible: true,
                colorText: Colors.white,
                dismissDirection: DismissDirection.horizontal,
              )
            })
        .catchError((error) => {print(error)});
  }

  Future<List<NoteModel>> getNotes() async {
    List<NoteModel> notes = [];

    QuerySnapshot querySnapshot = await _collection.orderBy('title').get();

    notes =
        querySnapshot.docs.map((doc) => NoteModel.fromMap(doc.data())).toList();

    return notes;
  }

  Future<NoteModel?> getNoteById(String id) async {
    NoteModel? note;

    await _collection.doc(id).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        note = NoteModel.fromMap(documentSnapshot.data());
      }
    });

    return note;
  }

  Future<void> update(String title,NoteModel note) async {
    await _collection.doc(note.id).set(note.toMap(),
      SetOptions(merge: true),
    );
    await NoteController.to.setNotes().then((_) => {Get.offAllNamed('/notes')});
    Get.snackbar(
      "Updated Success",
      title + " has been updated successfully",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 5),
      isDismissible: true,
      colorText: Colors.white,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}

import 'package:contack_and_note/app/data/models/note_model.dart';
import 'package:contack_and_note/app/data/services/firestore_note_service.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  static NoteController get to => Get.find();
  FirestoreNoteService firestoreNoteService = FirestoreNoteService();
  var notes = <NoteModel>[].obs;

  var notesLength = 0.obs;

  NoteController(){
    setNotes();
  }


  Future<void> setNotes() async{
    await firestoreNoteService
    .getNotes().then((values) =>{
      notes.assignAll(values),
      notes.refresh()
    });

    notesLength.value = notes.length;
  }
}
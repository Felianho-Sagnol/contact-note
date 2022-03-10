import 'package:contack_and_note/app/data/models/note_model.dart';
import 'package:contack_and_note/app/data/services/firestore_note_service.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  static NoteController get to => Get.find();
  FirestoreNoteService firestoreNoteService = FirestoreNoteService();
  var notes = <NoteModel>[].obs;

  NoteController(){
    setNotes();
  }


  List<NoteModel> getFirstNotes(){
    var firstNotes = <NoteModel>[];
    for(var i = 0; i < notes.length; i++){
      if(i==5) break;
      firstNotes.add(notes[i]);
    }

    return firstNotes;
  }

  Future<void> setNotes() async{
    await firestoreNoteService
    .getNotes().then((values) =>{
      notes.assignAll(values),
      notes.refresh()
    });
  }
}
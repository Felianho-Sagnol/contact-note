import 'package:contack_and_note/app/data/models/contact_model.dart';
import 'package:contack_and_note/app/data/services/firestore_contact_service.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  static ContactController get to => Get.find();
  FirestoreContactService firestoreContactService = FirestoreContactService();
  var contacts = <ContactModel>[].obs;

  ContactController(){
    setContacts();
  }

  List<ContactModel> getFirstContacts(){
    var firstContacts = <ContactModel>[];
    for(var i = 0; i < contacts.length; i++){
      print(i);
      if(i==5) break;
      firstContacts.add(contacts[i]);
    }

    return firstContacts;
  }


  Future<void> setContacts() async{
    await firestoreContactService
    .getContacts().then((values) =>{
      contacts.assignAll(values),
      contacts.refresh()
    });
  }
}
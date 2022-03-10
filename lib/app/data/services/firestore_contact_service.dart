import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contack_and_note/app/controllers/contact_controller.dart';
import 'package:contack_and_note/app/data/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirestoreContactService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('contacts');

  Future<void> add(ContactModel contact) async {
    await _collection
        .add(contact.toMap())
        .then(
          (doc) => {
            _collection.doc(doc.id).update({'id': doc.id}),
            ContactController.to.setContacts().then(
                  (_) => {
                    Get.snackbar(
                      "Add Success",
                      contact.fullName + " has been added successfully",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                      isDismissible: true,
                      colorText: Colors.white,
                      dismissDirection: DismissDirection.horizontal,
                    ),
                    Get.offAllNamed('/contacts'),
                  },
                ),
          },
        )
        .catchError((error) => {print(error)});
  }

  Future<List<ContactModel>> getContacts() async {
    List<ContactModel> contacts = [];

    QuerySnapshot querySnapshot = await _collection.orderBy('fullName').get();

    contacts = querySnapshot.docs
        .map((doc) => ContactModel.fromMap(doc.data()))
        .toList();

    return contacts;
  }

  Future<ContactModel?> getContactById(String id) async {
    ContactModel? contact;

    await _collection.doc(id).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        contact = ContactModel.fromMap(documentSnapshot.data());
      }
    });

    return contact;
  }

  Future<void> update(String fullName, ContactModel contact) async {
    await _collection.doc(contact.id).set(
          contact.toMap(),
          SetOptions(merge: true),
        );
    await ContactController.to.setContacts().then(
          (_) => {
            Get.snackbar(
              "Updated Success",
              fullName + " has been updated successfully",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 5),
              isDismissible: true,
              colorText: Colors.white,
              dismissDirection: DismissDirection.horizontal,
            ),
            Get.offAllNamed('/contacts'),
          },
        );
  }
}

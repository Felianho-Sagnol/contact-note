import 'package:contack_and_note/app/core/themes/theme_helper.dart';
import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:contack_and_note/app/data/models/contact_model.dart';
import 'package:contack_and_note/app/data/models/note_model.dart';
import 'package:contack_and_note/app/data/models/note_model.dart';
import 'package:contack_and_note/app/data/services/firestore_contact_service.dart';
import 'package:contack_and_note/app/data/services/firestore_note_service.dart';
import 'package:contack_and_note/app/global_widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddContact extends StatelessWidget {
  AddContact({Key? key}) : super(key: key);

  bool addNewContact = true;
  ContactModel? contact;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameControler = new TextEditingController();
  final TextEditingController emailControler = new TextEditingController();
  final TextEditingController phoneControler = new TextEditingController();
  final TextEditingController commentControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      if (Get.arguments['contact'] != null) {
        addNewContact = false;
        contact = Get.arguments['contact'];
        fullNameControler.text = contact!.fullName.toString();
        emailControler.text = contact!.email.toString();
        phoneControler.text = contact!.phone.toString();
        commentControler.text = contact!.comment.toString();
      }
    }
    var addText = addNewContact? "Add a new contact" : "Update the contact";
    return SafeArea(
      child: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          title: addNewContact? Text("Add new contact") : Text("Update the contact"),
          elevation: 0.5,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              FirestoreContactService contactService = FirestoreContactService();
              var now = DateTime.now();
              var formatter = DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(now);
              if(addNewContact){
                ContactModel newContact = ContactModel(
                  userUid: UserController.to.user().uid,
                  fullName: fullNameControler.text,
                  email: emailControler.text,
                  phone: phoneControler.text,
                  comment: commentControler.text,
                  createdAt: formattedDate,
                  updatedAt: formattedDate);
                  print(newContact);
                  await contactService.add(newContact);
              }else{
                var fullName = contact!.fullName;
                if(contact != null){
                  contact?.update(
                    emailControler.text,
                    phoneControler.text,
                    fullNameControler.text,
                    commentControler.text,
                    formattedDate
                  );
                }
                await contactService.update(fullName,contact!);
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
                          controller: fullNameControler,
                          decoration: ThemeHelper().textInputDecoration(
                            'Full Name',
                            'Enter the name',
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the name";
                            }
                            return null;
                          },
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      SizedBox(height: 35),
                      Container(
                        child: TextFormField(
                          controller: phoneControler,
                          keyboardType: TextInputType.phone,
                          decoration: ThemeHelper().textInputDecoration(
                            'Phone Number',
                            'Enter the phone number',
                          ),
                          validator: (val) {
                            if (!RegExp(r"^(\+[0-9]{1,5})?[0-9]{8,}$")
                                        .hasMatch(val!)) {
                              return "Enter the phone number";
                            }
                            return null;
                          },
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      SizedBox(height: 35),
                      Container(
                        child: TextFormField(
                          controller: emailControler,
                          decoration: ThemeHelper().textInputDecoration(
                            'Email address (optional)',
                            'Enter the email if you have',
                          ),
                          validator: (val) {
                            if (!val!.isEmpty && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                            .hasMatch(val)) {
                              return "Enter valid email address or let it empty";
                            }
                            return null;
                          },
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      SizedBox(height: 35),
                      TextFormField(
                        controller: commentControler,
                        minLines: 5,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          //labelText: "Content",
                          hintText: "Enter some comment",
                          labelText: "Comment (optional)",
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

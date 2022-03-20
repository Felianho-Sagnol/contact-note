import 'dart:io';

import 'package:contack_and_note/app/core/themes/theme_helper.dart';
import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:contack_and_note/app/data/models/contact_model.dart';
import 'package:contack_and_note/app/data/models/note_model.dart';
import 'package:contack_and_note/app/data/models/note_model.dart';
import 'package:contack_and_note/app/data/services/firestorage_service.dart';
import 'package:contack_and_note/app/data/services/firestore_contact_service.dart';
import 'package:contack_and_note/app/data/services/firestore_note_service.dart';
import 'package:contack_and_note/app/global_widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  bool addNewContact = true;
  ContactModel? contact;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameControler = new TextEditingController();
  final TextEditingController emailControler = new TextEditingController();
  final TextEditingController phoneControler = new TextEditingController();
  final TextEditingController commentControler = new TextEditingController();

  File? _image;
  FirestorageService _firestorageService = FirestorageService();
  Future<void> _getImage(int type) async {
    final picker = ImagePicker();

    var image = await picker.pickImage(
      source: type == 1 ? ImageSource.gallery : ImageSource.camera,
    );

    setState(() {
      _image = File(image!.path);
      debugPrint('$_image');
    });
  }

  bool isLoading = false;

  @override
  initState() {
    setState(() {
      isLoading = false;
    });
  }

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
    var addText = addNewContact ? "Add a new contact" : "Update the contact";
    return SafeArea(
      child: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          title: addNewContact
              ? Text(
                  "New contact",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                )
              : Text(
                  "Update the contact",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
          elevation: 0.5,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              FirestoreContactService contactService =
                  FirestoreContactService();
              var now = DateTime.now();
              var formatter = DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(now);
              String imageUrl = "";
              if (addNewContact) {
                imageUrl = await _firestorageService.uploadContactImageToStorge(
                  _image!,
                );
                ContactModel newContact = ContactModel(
                  userUid: UserController.to.user().uid,
                  fullName: fullNameControler.text,
                  email: emailControler.text,
                  phone: phoneControler.text,
                  comment: commentControler.text,
                  createdAt: formattedDate,
                  updatedAt: formattedDate,
                  imageUrl: imageUrl,
                );
                print(newContact);
                await contactService.add(newContact);
                setState(() {
                  isLoading = false;
                });
                Get.offAllNamed(
                  '/contacts',
                );
              } else {
                var fullName = contact!.fullName;
                if (contact != null) {
                  contact?.update(
                      emailControler.text,
                      phoneControler.text,
                      fullNameControler.text,
                      commentControler.text,
                      formattedDate);
                }
                await contactService.update(fullName, contact!);
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
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding : EdgeInsets.only(right:40,left:40),
                  height: 120,
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.none,
                      scale: 5.0,
                      image: (_image != null)
                          ? FileImage(_image!) as ImageProvider
                          : AssetImage(
                              'assets/images/profile1.png',
                            ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    "Choose picture from",
                    style: TextStyle(
                      color: HexColor("#018786"),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: GestureDetector(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () async {
                                  await _getImage(0);
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 20.0,
                                ),
                                color: HexColor("#018786"),
                              ),
                            ),
                            Text(
                              'camera',
                              style: TextStyle(
                                color: HexColor("#018786"),
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () async {
                                  await _getImage(1);
                                },
                                icon: Icon(
                                  Icons.collections,
                                  size: 20.0,
                                ),
                                color: HexColor("#018786"),
                              ),
                            ),
                            Text(
                              'galery',
                              style: TextStyle(
                                color: HexColor("#018786"),
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                (isLoading) ? CircularProgressIndicator() : Text(''),
                SizedBox(height: 10),
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
                            if (!val!.isEmpty &&
                                !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
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

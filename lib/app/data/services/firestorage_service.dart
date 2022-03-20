import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirestorageService{


  Future<String> uploadImageToStorge(File? image) async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString()+basename(image!.path);
    var  _firestorageReference = FirebaseStorage.instance.ref().child('profils').child(fileName);
    UploadTask  uploadTask = _firestorageReference.putFile(image);
    String imageUrl = await (await uploadTask).ref.getDownloadURL();


    return imageUrl;
  }

    Future<String> uploadContactImageToStorge(File? image) async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString()+basename(image!.path);
    var  _firestorageReference = FirebaseStorage.instance.ref().child('contactsImages').child(fileName);
    UploadTask  uploadTask = _firestorageReference.putFile(image);
    String imageUrl = await (await uploadTask).ref.getDownloadURL();

    return imageUrl;
  }
}
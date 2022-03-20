import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImageService{
  final picker = ImagePicker();
  late final File _imageFile;


  /** ImageFuture getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    this._imageFile = File(pickedFile!.path);
  }*/

  /*Future getImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
      print('image path $_imageFile');
    });
  }*/
}
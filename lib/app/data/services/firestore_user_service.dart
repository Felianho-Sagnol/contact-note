// ignore_for_file: non_constant_identifier_names, file_names, unnecessary_this, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contack_and_note/app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUserService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addUserToFireBase({
    required String email,
    required String fullName,
    required String phone,
    String imageUrle = "",
  }) async {
    User? user = _auth.currentUser;

    if (user != null) {
      UserModel userModel = UserModel(
        fullName: fullName,
        email: email,
        phone: phone,
        uid: user.uid,
        imageUrle: imageUrle,
      );

      await this
          ._firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toMap());
    }
  }

  Future<UserModel> getUserByUid(String uid) async {
    UserModel user = UserModel();
    await _firebaseFirestore.collection('users')
    .doc(uid)
    .get()
    .then((snapshot) => {
      user = UserModel.fromMap(snapshot.data()),
    });
    return user;
  }
}

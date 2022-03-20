import 'package:contack_and_note/app/data/enums/auth_enum.dart';
import 'package:contack_and_note/app/data/models/user_model.dart';
import 'package:contack_and_note/app/data/services/fireStore_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signin(
      {required String email, required String password}) async {
    String errorMessage = "";
    FirestoreUserService firestoreUserService = FirestoreUserService();
    try {
      UserModel user = UserModel();
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (userCredential) => {
              firestoreUserService
                  .getUserByUid(userCredential.user!.uid)
                  .then((value) => user = value),
            },
          );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "The user with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "The user with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests sended .";
          break;
        default:
          errorMessage = "An undefined Error happened, try it later.";
      }
    } catch (e) {
      errorMessage = "An undefined Error happened, try it later.";
    }
    return errorMessage;
  }

  Future<String> register(
      {required String email, required String password}) async {
    String errorMessage = "";
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      errorMessage = "";
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "email-already-in-use":
          errorMessage = "The account already exists for that email.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    } catch (e) {
      print(e);
      errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }

  Future logOut() async{
    _auth.signOut().then((_) {
      Get.offAllNamed('/login');
    });
  }
}

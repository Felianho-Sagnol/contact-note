import 'package:contack_and_note/app/data/models/user_model.dart';
import 'package:contack_and_note/app/data/services/fireStore_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  final  user =  UserModel().obs;
  static UserController get to => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreUserService firestoreUserService = FirestoreUserService();

  UserController(){
    initializeUser(); 
  }

  setUser(UserModel user) {
    this.user(user);
  }

  bool isAuthenticated() {
    if(_auth.currentUser == null) return false;
    return _auth.currentUser!.uid != null;
  }

  Future initializeUser() async {
    if(isAuthenticated()){
      await firestoreUserService.getUserByUid(_auth.currentUser!.uid).then((user) => {
        setUser(user)
      });
    }
  }


}
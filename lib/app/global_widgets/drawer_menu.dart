import 'package:contack_and_note/app/controllers/contact_controller.dart';
import 'package:contack_and_note/app/controllers/note_controller.dart';
import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:contack_and_note/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuDrawer extends StatelessWidget {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: UserController.to.isAuthenticated()
          ? ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 250,
                  child: DrawerHeader(
                    child: Container(
                      width: double.infinity,
                      //height: 100,
                      padding: EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/profile1.png'),
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              UserController.to.user().fullName,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 5),
                          Obx(
                            () => Text(
                              UserController.to.user().email,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                          ),
                          SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () =>
                      {Navigator.of(context).pop(), Get.offAllNamed('/home')},
                ),
                ListTile(
                  leading: Icon(Icons.manage_accounts),
                  title: Text('Profile'),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Get.offAllNamed('/profile')
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Get.offAllNamed('/profile'),
                  },
                ),
                ListTile(
                  leading: Icon(Icons.border_color),
                  title: Text('My Notes (' +
                      NoteController.to.notesLength.value.toString() +
                      ')'),
                  onTap: () => {
                    //Navigator.of(context).pop(),
                    Get.offNamed('/notes')
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_page),
                  title: Text(
                    'My Contacts (' +
                        ContactController.to.contactsLength.value.toString() +
                        ')',
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Get.offAllNamed('/contacts')
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () async => {
                    //await this._auth.logOut(),
                    Navigator.of(context).pop(),
                    Get.defaultDialog(
                      title: "Log out",
                      content: Text("Are you sur to logout ?"),
                      barrierDismissible: false,
                      confirm: ElevatedButton(
                        child: Text("YES"),
                        onPressed: () async {
                          Get.back();
                          await this._auth.logOut();
                        },
                      ),
                      cancel: ElevatedButton(
                        child: Text("No"),
                        onPressed: () {
                          Get.back();
                          //Navigator.of(context).pop();
                        },
                      ),
                    )
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help_center),
                  title: Text("About the application"),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Get.offAllNamed('/contacts')
                  },
                ),
              ],
            )
          : ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      //height: 100,
                      padding: EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/profile1.png'),
                              ),
                            ),
                          ),
                          Text(
                            "home",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.input),
                  title: Text('Welcome'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(Icons.verified_user),
                  title: Text('Registration'),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  leading: Icon(Icons.border_color),
                  title: Text('Sign In'),
                  onTap: () =>
                      {Navigator.of(context).pop(), Get.offAllNamed('/login')},
                ),
              ],
            ),
    );
  }
}

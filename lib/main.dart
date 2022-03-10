import 'package:contack_and_note/app/modules/contact/add_contact_page.dart';
import 'package:contack_and_note/app/modules/contact/contact_page.dart';
import 'package:contack_and_note/app/modules/home/home_page.dart';
import 'package:contack_and_note/app/modules/note/add_note_page.dart';
import 'package:contack_and_note/app/modules/note/note_page.dart';
import 'package:contack_and_note/app/modules/profile/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/utils/is_authenticated_midleware.dart';
import 'app/core/utils/is_not_authenticated_midleware.dart';
import 'app/data/services/global_binding_service.dart';
import 'app/modules/login/login_page.dart';
import 'app/modules/register/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Contacts & Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: GlobalBinding(),
      unknownRoute: GetPage(name: '/notfound', page: () => Home()),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => Home(),
          middlewares: [
            IsNotAuthenticatedMidleware(),
          ],
        ),
        GetPage(
          name: '/login',
          page: () => Login(),
          middlewares: [
            IsAuthenticatedMidleware(),
          ],
        ),
        GetPage(
          name: '/register',
          page: () => Register(),
          middlewares: [
            IsAuthenticatedMidleware(),
          ],
        ),
        GetPage(
          name: '/profile',
          page: () => Profile(),
          middlewares: [
            IsNotAuthenticatedMidleware(),
          ],
        ),
        GetPage(
          name: '/notes',
          page: () => Note(),
          middlewares: [
            IsNotAuthenticatedMidleware(),
          ],
        ),
        GetPage(
          name: '/add-note',
          page: () => AddNote(),
          middlewares: [
            IsNotAuthenticatedMidleware(),
          ],
        ),GetPage(
          name: '/contacts',
          page: () => Contact(),
          middlewares: [
            IsNotAuthenticatedMidleware(),
          ],
        ),
        GetPage(
          name: '/add-contact',
          page: () => AddContact(),
          middlewares: [
            IsNotAuthenticatedMidleware(),
          ],
        )
      ],
    );
  }
}

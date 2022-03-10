import 'package:contack_and_note/app/core/themes/theme_helper.dart';
import 'package:contack_and_note/app/core/utils/user_controller.dart';
import 'package:contack_and_note/app/data/services/auth_service.dart';
import 'package:contack_and_note/app/data/services/fireStore_user_service.dart';
import 'package:contack_and_note/app/global_widgets/header_widget.dart';
import 'package:contack_and_note/app/modules/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  bool hasSelected = false;

  final fullNameEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 150,
                child: HeaderWidget(150),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border:
                                        Border.all(width: 5, color: Colors.white),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        offset: const Offset(5, 5),
                                      ),
                                    ],
                                  ),
                                  child: (1 != 1)
                                      ? Text('eee')
                                      : Icon(
                                          Icons.person,
                                          color: Colors.grey.shade300,
                                          size: 80.0,
                                        ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: TextFormField(
                              controller: fullNameEditingController,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Full Name', 'Enter your Full name'),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter your Full name";
                                }
                                return null;
                              },
                            ),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: emailEditingController,
                              decoration: ThemeHelper().textInputDecoration(
                                  "E-mail address", "Enter your email"),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(val)) {
                                  return "Enter a valid email address";
                                }
                                return null;
                              },
                            ),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: phoneEditingController,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Mobile Number", "Enter your mobile number"),
                              keyboardType: TextInputType.phone,
                              validator: (val) {
                                if (val!.isEmpty ||
                                    !RegExp(r"^(\+[0-9]{1,5})?[0-9]{8,}$")
                                        .hasMatch(val)) {
                                  return "Enter a valid phone number";
                                }
                                return null;
                              },
                            ),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: passwordEditingController,
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Password", "Enter your password"),
                              validator: (val) {
                                if (val!.isEmpty || val.length < 6) {
                                  return "Password most be More than 6 characters.";
                                }
                                return null;
                              },
                            ),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: confirmPasswordEditingController,
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Confirm Password", "Confirm the password"),
                              validator: (val) {
                                if (val!.isEmpty || val.length < 6) {
                                  return "Password most be More than 6 characters.";
                                } else if (confirmPasswordEditingController
                                            .text !=
                                        passwordEditingController.text &&
                                    passwordEditingController.text.length >= 6) {
                                  return "Password don't match";
                                }
    
                                return null;
                              },
                            ),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 15.0),
                          FormField<bool>(
                            builder: (state) {
                              return Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: checkboxValue,
                                          onChanged: (value) {
                                            setState(() {
                                              checkboxValue = value!;
                                              state.didChange(value);
                                            });
                                          }),
                                      Text(
                                        "I accept all terms and conditions.",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      state.errorText ?? '',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Theme.of(context).errorColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                            validator: (value) {
                              if (!checkboxValue) {
                                return 'You need to accept terms and conditions';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                            //alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                print('adding picture');
                              },
                              child: Text(
                                "Add profile picture here",
                                style: TextStyle(
                                  color: HexColor("#018786"),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.camera_alt),
                              color: HexColor("#018786"),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "Register".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  String fullName =
                                      this.fullNameEditingController.text;
                                  String email = this.emailEditingController.text;
                                  String phone = this.phoneEditingController.text;
                                  String password =
                                      this.passwordEditingController.text;
    
                                  AuthService authService = AuthService();
                                  FirestoreUserService firestoreUserService =
                                      FirestoreUserService();
                                  print(email + " " + password);
                                  await authService
                                      .register(
                                        email: email,
                                        password: password,
                                      )
                                      .then(
                                        (value) => {
                                          if (value.length != 0)
                                            {
                                              Get.snackbar(
                                                "Registration Error !!",
                                                value,
                                                snackPosition: SnackPosition.TOP,
                                                backgroundColor: Colors.red,
                                                duration: Duration(seconds: 5),
                                                isDismissible: true,
                                                colorText: Colors.white,
                                                dismissDirection:
                                                    DismissDirection.horizontal,
                                              )
                                            }
                                          else
                                            {
                                              firestoreUserService
                                                  .addUserToFireBase(
                                                      email: email,
                                                      fullName: fullName,
                                                      phone: phone)
                                                  .then(
                                                    (_) => {
                                                      UserController.to
                                                          .initializeUser()
                                                          .then(
                                                            (_) =>
                                                                Get.offAllNamed(
                                                              '/',
                                                            ),
                                                          ),
                                                    },
                                                  ),
                                            }
                                        },
                                      );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 30.0),
                          TextButton(
                              onPressed: () {
                                Get.offNamed('/login');
                              },
                              child: Text(
                                "I have an account !",
                                style: TextStyle(color: Colors.grey),
                              )),
                          SizedBox(height: 25.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

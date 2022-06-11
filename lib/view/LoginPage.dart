import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:istegelsinfinal/model/User.dart';
import 'package:istegelsinfinal/validate/Validator.dart';
import 'package:istegelsinfinal/view/Drawer.dart';
import 'package:istegelsinfinal/view/Register.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/auth_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
    with Validator, TickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final formKey = GlobalKey<FormState>();
  final User user = User.empty();
  String checkEmail = "";
  String checkPassword = "";

  late AnimationController animationController;

  late Animation<double> rotateAnimationValue;
  late Animation<double> scaleAnimationValue;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    rotateAnimationValue =
        Tween(begin: 0.0, end: pi * 2).animate(animationController)
          ..addListener(() {
            setState(() {});
          });
    scaleAnimationValue =
        Tween(begin: 350.0, end: 150.0).animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  Future<void> writeData() async {
    var name = await getApplicationDocumentsDirectory();
    var path = name.path;
    var file = File("$path/info.txt");
    file.writeAsString(checkEmail + " " + checkPassword);
  }

  Future<void> readData() async {
    try {
      var name = await getApplicationDocumentsDirectory();
      var path = name.path;
      var file = File("$path/info.txt");

      String data = await file.readAsString();
      debugPrint("data : $data");
    } catch (e) {
      e.toString();
    }
  }

  Future<void> deleteData() async {
    var name = await getApplicationDocumentsDirectory();
    var path = name.path;
    var file = File("$path/info.txt");

    if (file.existsSync()) {
      file.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Center(child: Text("Giriş Yap")),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  loginImage(),
                  emailField(),
                  passwordField(),
                  submitButton(),
                  registerText(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget loginImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 70, bottom: 8),
      child: Transform.rotate(
        angle: rotateAnimationValue.value,
        child: SizedBox(
            height: 170,
            child: Image.asset(
              "images/login.png",
              width: scaleAnimationValue.value,
              height: scaleAnimationValue.value,
            )),
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onSaved: (String? value) {
          checkEmail = value!;
        },
        decoration: InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
          ),
        ),
        validator: validateEmail,
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onSaved: (String? value) {
          checkPassword = value!;
        },
        decoration: InputDecoration(
          labelText: "Şifre",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
          ),
        ),
        validator: validatePassword,
        obscureText: true,
      ),
    );
  }

  Widget submitButton() {
    return Container(
      //width: 200,
      child: SizedBox(
        height: 40,
        width: scaleAnimationValue.value,
        child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              setState(() async {
                if (checkEmail.isNotEmpty && checkPassword.isNotEmpty) {
                  var sp = await SharedPreferences.getInstance();
                  sp.setString("email", checkEmail);
                  sp.setString("password", checkPassword);
                  writeData();
                  readData();

                  _authService.signInWithEmail(checkEmail, checkPassword).then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => DrawerPage()),
                          (route) => false));
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.deepOrange,
                          elevation: 15,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          title: const Text(
                            "Hatalı Giriş",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.black),
                          ),
                          content: const Text(
                            "Kullanıcı adı veya parola yanlış. Lütfen tekrar deneyin.",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Tekrar Dene"),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                            ),
                          ],
                        );
                      });
                }
              });
            }
          },
          child: const Text(
            "Giriş Yap",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))),
        ),
      ),
    );
  }

  Widget registerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Hesabın yok mu?",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
            child: const Text(
              "Hemen Kaydol",
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}

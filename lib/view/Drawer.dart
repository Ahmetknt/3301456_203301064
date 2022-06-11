import 'package:flutter/material.dart';
import 'package:istegelsinfinal/service/auth_service.dart';
import 'package:istegelsinfinal/view/Anasayfa.dart';
import 'package:istegelsinfinal/view/GorusveOneriler.dart';
import 'package:istegelsinfinal/view/Grafik.dart';
import 'package:istegelsinfinal/view/LoginPage.dart';

import 'Sepet.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  AuthService authService = AuthService();
  var pageList = [
    Anasayfa(),
    Sepet.empty(),
    Grafik(),
    GorusveOneriler(),
    Login()
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Text(
                  "Merhaba : Ahmet",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
            ListTile(
              title: Text("Anasayfa"),
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Sepet"),
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("İstatistikler"),
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Görüş ve Öneriler"),
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Çıkış Yap"),
              onTap: () {
                setState(() {
                  authService.signOut();
                  selectedIndex = 4;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
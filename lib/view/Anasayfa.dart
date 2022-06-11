import 'package:flutter/material.dart';
import 'package:istegelsinfinal/db/KategoriDAO.dart';
import 'package:istegelsinfinal/model/Category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';
import 'Urunler.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  Future<List<Category>> allCategory() async {
    var categoryList = await KategoriDAO().allCategory();

    for (Category k in categoryList) {
      print("Ad : ${k.kategoriAd}");
    }

    return categoryList;
  }

  late String username;
  late String password;

  Future<void> loginBilgi() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      username = sp.getString("username") ?? "yok";
      password = sp.getString("password") ?? "yok";
    });
  }

  Future<void> logOut() async {
    var sp = await SharedPreferences.getInstance();

    sp.remove("username");
    sp.remove("password");

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  void initState() {
    super.initState();
    allCategory();
    loginBilgi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text("Kategoriler")),
      ),
      body: FutureBuilder<List<Category>>(
          future: allCategory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var categoryList = snapshot.data;
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                  itemCount: categoryList!.length,
                  itemBuilder: (context, index) {
                    var category = categoryList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Urunler(category: category)));
                      },
                      child: Card(
                          child: Column(
                        children: [
                          Image.asset(category.kategoriImage),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Text(
                              category.kategoriAd,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                            ),
                          )
                        ],
                      )),
                    );
                  });
            } else {
              return const Center();
            }
          }),
    );
  }
}

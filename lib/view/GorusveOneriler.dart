import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class GorusveOneriler extends StatefulWidget {
  @override
  State<GorusveOneriler> createState() => _GorusveOnerilerState();
}

class _GorusveOnerilerState extends State<GorusveOneriler> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController addController = TextEditingController();
  TextEditingController updateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String updateData = "";
    CollectionReference suggestionCollection =
        _firestore.collection("Suggestion");
    return Scaffold(
      appBar: AppBar(
        title: Text("Görüş ve Öneriler"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: suggestionCollection.snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Bir hata oluştu.Lütfen daha sonra tekrar deneyiniz"),
                    );
                  } else {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> document = snapshot.data.docs;
                      return Flexible(
                        child: Container(
                          height: 550,
                          child: ListView.builder(
                            itemCount: document.length,
                            itemBuilder: (context, index) {
                              var comment = document[index].data()
                                  as Map<String, dynamic>;
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          elevation: 15,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          title: const Text(
                                            "Güncelleme",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          content: TextField(
                                            onChanged: (value) {
                                              updateData = value;
                                            },
                                            controller: updateController,
                                            decoration: InputDecoration(
                                                hintText: "Görüşünüz"),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("İptal"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                await suggestionCollection
                                                    .doc("${comment["uuid"]}")
                                                    .update({
                                                  "opinion": updateData
                                                });
                                                updateController.text = "";
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Güncelle"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.blue),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Card(
                                  color: Colors.black,
                                  child: ListTile(
                                    title: Text(
                                      "İstek ve Öneriler",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      "${comment["opinion"]}",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () async {
                                        await document[index]
                                            .reference
                                            .delete();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: addController,
                      decoration: InputDecoration(hintText: "Görüşünüz : "),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var uuid = Uuid();
          var deger = uuid.v1();
          Map<String, dynamic> addOpinion = {
            "uuid": deger,
            "opinion": addController.text
          };
          await suggestionCollection.doc(deger).set(addOpinion);
          addController.text = "";
        },
        child: Text("Ekle"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:istegelsinfinal/db/UrunDAO.dart';
import 'package:istegelsinfinal/items/SepetList.dart';
import 'package:istegelsinfinal/model/Category.dart';
import 'package:istegelsinfinal/utils/count.dart';
import 'package:istegelsinfinal/view/Sepet.dart';

import '../model/Food.dart';
import 'Detay.dart';

class Urunler extends StatefulWidget {
  late Category category;
  Urunler({required this.category});

  @override
  _UrunlerState createState() => _UrunlerState();
}

class _UrunlerState extends State<Urunler> {
  Future<List<Food>> allUrun(int kategoriId) async {
    var urunList = await UrunDAO().tumUrunlerByKategoriId(kategoriId);

    for (Food f in urunList) {
      print(f.category);
      print(f.id);
      print(f.category.kategoriAd);
      print(f.totalPrice);
    }

    return urunList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category.kategoriAd),
        ),
        body: FutureBuilder<List<Food>>(
          future: allUrun(widget.category.kategoriId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var foods = snapshot.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1 / 1.65),
                itemCount: foods!.length,
                itemBuilder: (context, index) {
                  var food = foods[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Detay(food: food)));
                    },
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                          side: const BorderSide(
                              width: 1, color: Colors.blueGrey)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(food.image),
                          ),
                          Text(
                            "\u{20BA}${food.price}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                                fontSize: 16),
                          ),
                          Text(food.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            food.gram,
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              Count.count += 1;
                              var s1 = Food.adet(
                                  adet: food.adet,
                                  name: food.name,
                                  gram: food.gram,
                                  price: food.price,
                                  totalPrice: food.totalPrice,
                                  image: food.image);
                              SepetList.sepet.add(s1);

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.blueGrey,
                                      elevation: 15,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      title: const Text(
                                        "İşlem Başarılı",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                      content: Text(
                                        "${food.name} Sepete Eklendi",
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Sepet(
                                                          adet: food.adet,
                                                          name: food.name,
                                                          price: food.price,
                                                          totalPrice:
                                                              food.totalPrice,
                                                          image: food.image,
                                                        )));
                                          },
                                          child: const Text("Sepete Git"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.black45),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: SizedBox(
                              width: 105,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.shopping_cart),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Sepete Ekle")
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepOrange),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text("aq");
            }
          },
        ));
  }
}

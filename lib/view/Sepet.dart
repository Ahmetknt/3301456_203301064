import 'package:flutter/material.dart';
import 'package:istegelsinfinal/items/SepetList.dart';
import 'package:istegelsinfinal/utils/count.dart';
import 'package:istegelsinfinal/view/Anasayfa.dart';

class Sepet extends StatefulWidget {
  late int adet;
  late String name;
  late int price;
  late int totalPrice;
  late String image;

  Sepet(
      {required this.adet,
      required this.name,
      required this.price,
      required this.totalPrice,
      required this.image});
  Sepet.empty();

  @override
  _SepetState createState() => _SepetState();
}

class _SepetState extends State<Sepet> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepet"),
      ),
      body: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height) - 135,
            child: ListView.builder(
                itemCount: Count.count,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        SepetList.sepet.removeAt(index);
                        Count.count -= 1;
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    SepetList.sepet[index].name,
                                    style: const TextStyle(
                                      fontSize: 23,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      FloatingActionButton.small(
                                        onPressed: () {
                                          setState(() {
                                            if (SepetList.sepet[index].adet >
                                                0) {
                                              SepetList.sepet[index].adet -= 1;
                                              SepetList.sepet[index]
                                                  .totalPrice = (SepetList
                                                      .sepet[index].price *
                                                  SepetList.sepet[index].adet);
                                            }
                                          });
                                        },
                                        child: const Icon(Icons.remove),
                                        tooltip: "Çıkar",
                                        backgroundColor: Colors.deepOrange,
                                        foregroundColor: Colors.white,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          "${SepetList.sepet[index].adet}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.deepOrange,
                                            elevation: 10,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            )),
                                      ),
                                      FloatingActionButton.small(
                                        onPressed: () {
                                          setState(() {
                                            SepetList.sepet[index].adet += 1;
                                            SepetList.sepet[index].totalPrice =
                                                (SepetList.sepet[index].price *
                                                    SepetList
                                                        .sepet[index].adet);
                                          });
                                        },
                                        child: const Icon(Icons.add),
                                        tooltip: "Ekle",
                                        backgroundColor: Colors.deepOrange,
                                        foregroundColor: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "${SepetList.sepet[index].totalPrice}\u{20BA}",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              Container(
                                color: Colors.blueGrey,
                                height: 100,
                                width: 2,
                              ),
                              Image.asset(SepetList.sepet[index].image)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Toplam Tutar : ${totalPrice()}\u{20BA}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey,
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        )),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (totalPrice() != 0.0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.blueGrey,
                                elevation: 15,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                title: const Text(
                                  "Siparişiniz Alındı",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27),
                                ),
                                content: Text(
                                  "Bizi tercih ettiğiniz için teşekkür ederiz.Siparişiniz belirttiğiniz adresinize en kısa sürede teslim edilecektir.",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Anasayfa()),
                                      );
                                    },
                                    child: const Text("Kapat"),
                                    style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        primary: Colors.red),
                                  )
                                ],
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.blueGrey,
                                elevation: 15,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                title: const Center(
                                    child: Text(
                                  "Sepet Boş",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                                content: const Text(
                                  "Lütfen sepete ürün ekleyin.",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Kapat"),
                                    style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        primary: Colors.red),
                                  )
                                ],
                              );
                            });
                      }
                    },
                    child: const Text(
                      "Siparişi Onayla",
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double totalPrice() {
    double totalPrice = 0;
    for (int i = 0; i < Count.count; i++) {
      totalPrice += SepetList.sepet[i].totalPrice;
    }
    totalPrice = (totalPrice * 100).floorToDouble() / 100;
    return totalPrice;
  }
}

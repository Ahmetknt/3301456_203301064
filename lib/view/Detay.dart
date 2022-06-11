import 'package:flutter/material.dart';
import 'package:istegelsinfinal/items/SepetList.dart';

import '../model/Food.dart';
import '../utils/count.dart';
import 'Sepet.dart';

class Detay extends StatefulWidget {
  late Food food;
  Detay({required this.food});

  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> {
  int count = 0;
  double tutar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Sepet.empty()));
              },
              child: Row(
                children: const [
                  Icon(Icons.card_travel),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Sepete Git")
                ],
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  elevation: 20,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(widget.food.image),
            const Spacer(),
            Text(
              widget.food.name,
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.food.gram,
                  style: const TextStyle(fontSize: 23, color: Colors.blueGrey),
                ),
                const SizedBox(
                  width: 35,
                ),
                Text("${widget.food.price}\u{20BA}",
                    style: const TextStyle(
                      fontSize: 23,
                      color: Colors.blueGrey,
                    ))
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.small(
                    onPressed: () {
                      setState(() {
                        if (count > 0) {
                          count -= 1;
                          tutar = (widget.food.price * count * 100)
                                  .floorToDouble() /
                              100;
                        }
                      });
                    },
                    child: const Icon(Icons.remove),
                    tooltip: "Çıkar",
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "$count",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        )),
                  ),
                  FloatingActionButton.small(
                    onPressed: () {
                      setState(() {
                        count += 1;
                        tutar =
                            (widget.food.price * count * 100).floorToDouble() /
                                100;
                      });
                    },
                    child: const Icon(Icons.add),
                    tooltip: "Ekle",
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (count != 0) {
                        Count.count += 1;
                        var s1 = Food.adet(
                            adet: count,
                            name: widget.food.name,
                            gram: widget.food.gram,
                            price: widget.food.price,
                            totalPrice: widget.food.totalPrice,
                            image: widget.food.image);
                        SepetList.sepet.add(s1);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                            "Lütfen kaç adet alacağınızı giriniz.",
                            style: TextStyle(color: Colors.red),
                          ),
                          duration: const Duration(seconds: 5),
                          backgroundColor: Colors.white,
                          action: SnackBarAction(
                            label: "Tamam",
                            textColor: Colors.green,
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                          ),
                        ));
                      }
                    },
                    child: Row(
                      children: [
                        const Text("Sepete Ekle",
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)),
                        const SizedBox(
                          width: 6,
                        ),
                        Container(
                          color: Colors.white,
                          height: 32,
                          width: 3,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          "$tutar \u{20BA}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

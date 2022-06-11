import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Grafik extends StatefulWidget {
  @override
  State<Grafik> createState() => _GrafikState();
}

class _GrafikState extends State<Grafik> {
  @override
  Widget build(BuildContext context) {
    var data = [
      Sales("Atıştırmalık", 30, Colors.blue),
      Sales("Kahvaltılık", 15, Colors.green),
      Sales("Temel Gıda", 20, Colors.yellow),
      Sales("Ev Bakım", 5, Colors.pink),
      Sales("Meyve & Sebze", 15, Colors.purple),
      Sales("Kişisel Bakım", 20, Colors.orange),
    ];

    var series = [
      charts.Series(
          domainFn: (Sales sales, _) => sales.category,
          measureFn: (Sales sales, _) => sales.ratio,
          colorFn: (Sales sales, _) => sales.color,
          id: "Sales",
          data: data,)
    ];

    var chart = charts.PieChart(series,
        animate: true, animationDuration: Duration(seconds: 5));

    return Scaffold(
      appBar: AppBar(
        title: Text("Grafik"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Kategorilerin Tercih Edilme Oranı",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 400, child: chart),
            Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Atıştırmalıklar",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Kahvaltılık",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Temel Gıda",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  color: Colors.pink,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Ev Bakım",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  color: Colors.purple,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Meyve & Sebze",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Kişisel Bakım",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Sales {
  late String category;
  late int ratio;
  late charts.Color color;

  Sales(this.category, this.ratio, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

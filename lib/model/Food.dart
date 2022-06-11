import 'package:istegelsinfinal/model/Category.dart';

class Food {
  late int id;
  late int adet;
  late String name;
  late String gram;
  late int price;
  late int totalPrice;
  late String image;
  late Category category;

  Food(
      {required this.id,
      required this.adet,
      required this.name,
      required this.gram,
      required this.price,
      required this.totalPrice,
      required this.image,
      required this.category});
  Food.adet(
      {required this.adet,
      required this.name,
      required this.gram,
      required this.price,
      required this.totalPrice,
      required this.image});
}

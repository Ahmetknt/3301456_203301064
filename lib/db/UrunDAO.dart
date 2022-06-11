import 'package:istegelsinfinal/db/DatabaseHelper.dart';
import 'package:istegelsinfinal/model/Category.dart';
import 'package:istegelsinfinal/model/Food.dart';

import 'DatabaseHelper.dart';

class UrunDAO {
  Future<List<Food>> tumUrunlerByKategoriId(int kategoriId) async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM URUN,Kategori WHERE Urun.kategoriId=Kategori.kategoriId"
        " AND Urun.kategoriId = $kategoriId");

    return List.generate(maps.length, (i) {
      var raw = maps[i];
      var k = Category(
          kategoriId: raw["kategoriId"],
          kategoriAd: raw["kategoriAd"],
          kategoriImage: raw["kategoriImage"]);

      return Food(
          id: raw["id"],
          adet: raw["adet"],
          name: raw["name"],
          gram: raw["gram"],
          price: raw["price"],
          totalPrice: raw["totalPrice"],
          image: raw["image"],
          category: k);
    });
  }
}

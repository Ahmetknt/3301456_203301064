import 'package:istegelsinfinal/db/DatabaseHelper.dart';
import 'package:istegelsinfinal/model/Category.dart';

class KategoriDAO {
  Future<List<Category>> allCategory() async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM Kategori");

    return List.generate(maps.length, (i) {
      var raw = maps[i];
      return Category(
          kategoriId: raw["kategoriId"],
          kategoriAd: raw["kategoriAd"],
          kategoriImage: raw["kategoriImage"]);
    });
  }
}

import 'package:charge_station_finder/domain/charger/charger.dart';
import 'package:charge_station_finder/infrastructure/dto/charger_dto.dart';
import 'package:sqflite/sqflite.dart';

class CRDatabase {
  static Future<Database> get instance async {
    return _dbInstance ??= await db();
  }

  static Database? _dbInstance;
  static Future<Database> db() async {
    return openDatabase(
      'ChargeRoute.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE chargers(
        id VARCHAR PRIMARY KEY ,
        name VARCHAR,
        address VARCHAR,
        description VARCHAR,
        phone VARCHAR,
        wattage DOUBLE,
        rating DOUBLE
      )
      """);
  }

  static Future<void> insertChargers(
      List<Map<String, dynamic>> chargers) async {
    final Database db = await instance;
    chargers.forEach((charger) async {
      await db.insert('chargers', charger,
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  static Future<List<Charger>> getChargers(String query) async {
    final Database db = await instance;
    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM chargers WHERE name LIKE '%$query%' OR address LIKE '%$query%'");
    return result.map((e) => ChargerDto.fromDb(e).toDomain()).toList();
  }

  static Future<void> deleteChargers() async {
    final Database db = await instance;
    await db.delete('chargers');
  }

  // close the database
  static Future<void> close() async {
    final Database db = await instance;
    db.close();
  }
}

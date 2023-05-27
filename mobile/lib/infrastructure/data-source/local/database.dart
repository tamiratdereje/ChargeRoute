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
    await database.execute("PRAGMA foreign_keys = ON");
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
    await database.execute("""
      CREATE TABLE reviews(
        id VARCHAR PRIMARY KEY ,
        chargerId VARCHAR,
        userId VARCHAR,
        rating DOUBLE,
        comment VARCHAR,
        FOREIGN KEY(chargerId) REFERENCES chargers(id) ON DELETE CASCADE,
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
    // get chargers with their corresponding reviews
    List<Map<String, dynamic>> result =   await db.rawQuery("""
      SELECT chargers.id, chargers.name, chargers.address, chargers.description, chargers.phone, chargers.wattage, chargers.rating, reviews.rating as reviewRating, reviews.comment as reviewComment
      FROM chargers
      LEFT JOIN reviews ON chargers.id = reviews.chargerId
      WHERE chargers.address LIKE '%$query%'
      """);
      
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

import 'package:charge_station_finder/domain/charger/charger.dart';
import 'package:charge_station_finder/infrastructure/dto/charger_dto.dart';
import 'package:flutter/cupertino.dart';
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
      onUpgrade: (Database database, int oldVersion, int newVersion) async {
        debugPrint("Upgrading database");
        await database.execute("DROP TABLE IF EXISTS chargers");
        await database.execute("DROP TABLE IF EXISTS reviews");
        await createTables(database);
      },
      onDowngrade: (Database database, int oldVersion, int newVersion) async {
        debugPrint("Downgrading database");
        await database.execute("DROP TABLE IF EXISTS chargers");
        await database.execute("DROP TABLE IF EXISTS reviews");
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(Database database) async {
    await database.execute("PRAGMA foreign_keys = ON");
    try {
      await database.execute("""
      CREATE TABLE chargers(
        id VARCHAR PRIMARY KEY,
        name VARCHAR,
        address VARCHAR,
        rating DOUBLE,
        wattage INTEGER,
        description VARCHAR,
        phone VARCHAR,
        authorId VARCHAR,
        hasUserRated INTEGER,
        userVote INTEGER
      )
      """);
      await database.execute("""
      CREATE TABLE reviews(
        id VARCHAR PRIMARY KEY,
        chargerId VARCHAR,
        userId VARCHAR,
        comment VARCHAR,
        FOREIGN KEY(chargerId) REFERENCES chargers(id) ON DELETE CASCADE
      )
      """);
    } catch (e) {
      debugPrint("Error creating tables: $e");
    }
    debugPrint("Tables created");
    List<Map<String, dynamic>> tables = await database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'android%' AND name NOT LIKE 'sqlite%'");
    tables.forEach((table) async {
      List<Map<String, dynamic>> columns =
          await database.rawQuery("PRAGMA table_info('${table['name']}')");
      debugPrint("Table: ${table['name']}");
      for (var column in columns) {
        debugPrint("Column: ${column['name']} - ${column['type']}");
      }
    });
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
    List<Map<String, dynamic>> result = await db.rawQuery("""
      SELECT chargers.id, 
      chargers.name,
      chargers.address,
      chargers.rating,
      chargers.wattage,
      chargers.description,
      chargers.phone, 
      chargers.authorId,
      chargers.hasUserRated,
      chargers.userVote,
      reviews.id as reviewId,
      reviews.userId as reviewAuthorId,
      reviews.comment as reviewComment
      FROM chargers
      INNER JOIN reviews ON chargers.id = reviews.chargerId
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

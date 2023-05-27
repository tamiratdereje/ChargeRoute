import 'package:charge_station_finder/domain/charger/charger.dart';
import 'package:charge_station_finder/infrastructure/dto/charger_dto.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

import '../../dto/review_dto.dart';

class CRDatabase {
  static Future<Database> get instance async {
    return _dbInstance ??= await db();
  }

  static Database? _dbInstance;

  static Future<Database> db() async {
    return openDatabase(
      'ChargeRoute.db',
      version: 4,
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
        description VARCHAR,
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
      var result = await db.query('chargers');
      debugPrint("Chargers: $result");
      debugPrint("Charger inserted");
    });
  }

  static Future<List<Charger>> getChargers(String query) async {
    final Database db = await instance;

    // get chargers with their corresponding reviews
    List<Map<String, dynamic>> result = await db.query('chargers',
        where: " address LIKE '%$query%'", orderBy: "rating DESC");

    List<List<Map<String, dynamic>>> reviewsResult = [];
    for (var charger in result) {
      List<Map<String, dynamic>> reviews = await db.query(
        'reviews',
        where: " chargerId = '${charger['id']}'",
        orderBy: "id DESC",
      );
      reviewsResult.add(reviews);
    }

    var response = List.generate(result.length, (index) {
      return ChargerDto.fromDb(result[index], reviewsResult[index]).toDomain();
    });
    // for each charger, get its reviews

    debugPrint("Chargers: $response");
    return response;
  }

  static Future<void> deleteChargers() async {
    final Database db = await instance;
    await db.delete('chargers');
  }

  static Future<void> insertReviews(List<Map<String, dynamic>> reviews) async {
    final Database db = await instance;
    // ignore: avoid_function_literals_in_foreach_calls
    reviews.forEach((review) async {
      await db.insert('reviews', review,
          conflictAlgorithm: ConflictAlgorithm.replace);

      var result = await db.query('reviews');
      debugPrint("Reviews: $result");
      debugPrint("Review inserted");
    });
  }

  // close the database
  static Future<void> close() async {
    final Database db = await instance;
    db.close();
  }
}

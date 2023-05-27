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
      version: 3,
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
        rating DOUBLE,
        voted INTEGER, )
      """);
    await database.execute("""
      CREATE TABLE reviews(
        id VARCHAR PRIMARY KEY ,
        chargerId VARCHAR,
        userId VARCHAR,
        rating DOUBLE,
        comment VARCHAR,
        FOREIGN KEY(chargerId) REFERENCES chargers(id) ON DELETE CASCADE
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
    List<Map<String, dynamic>> chargerMaps = await db
        .query('chargers', where: 'address LIKE ?', whereArgs: ['%$query%']);
    debugPrint(' Charger Maps :$chargerMaps');


    

    // get reviews for each charger map
    for (var chargerMap in chargerMaps) {
      final List<Map<String, dynamic>> reviewMaps = await db.query('reviews',
          where: 'chargerId = ?', whereArgs: [chargerMap['id']]);

      debugPrint(' Review Maps :$reviewMaps');
      // set reviews for each charger map
    }
    // convert charger maps to charger objects
    if (chargerMaps.isNotEmpty) {
      return chargerMaps
          .map((chargerMap) => ChargerDto.fromDb(chargerMap).toDomain())
          .toList(growable: false);
    }
    return <Charger>[];
  }

  static Future<void> deleteChargers() async {
    final Database db = await instance;
    await db.delete('chargers');
  }

  static Future<void> insertReviews(List<Map<String, dynamic>> reviews) async {
    final Database db = await instance;
    reviews.forEach((review) async {
      await db.insert('reviews', review,
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  // close the database
  static Future<void> close() async {
    final Database db = await instance;
    db.close();
  }
}

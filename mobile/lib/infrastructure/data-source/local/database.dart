import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CRDatabase{
  Database? _database;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      create table Charger ( 
        id varchar primary key not null,, 
        name varchar not null,
        description varchar not null,
        address varchar not null,
        phone varchar not null,
        wattage double not null,
        rating double not null
      )
      ''');
  }

}
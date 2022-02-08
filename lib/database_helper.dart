import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'entity/data.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'datas';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'data_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id INTEGER PRIMARY KEY AUTOINCREMENT,
               nama TEXT, 
               alamat TEXT, 
               tanggalLahir TEXT, 
               tinggi TEXT, 
               berat TEXT, 
               foto TEXT
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<List<Data>> getDatas() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => Data.fromMap(res)).toList();
  }

  Future<void> insertData(Data data) async {
    final Database db = await database;
    await db.insert(_tableName, data.toMap());
    print('Data saved');
    print(data.toMap());
  }
}

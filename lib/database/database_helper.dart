import 'package:plaka_sorgu/model/car_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'cars';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cars_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      plate TEXT,
      brand TEXT,
      color TEXT,
      owner TEXT
    )
  ''');
  }

  Future<int> insertCar(Car car) async {
    Database? db = await instance.database;
    return await db!.insert(tableName, car.toMap());
  }

  Future<List<Car>> getCars() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> maps = await db!.query(tableName);
    return List.generate(maps.length, (index) => Car.fromMap(maps[index]));
  }

  Future<int> deleteCar(int id) async {
    Database? db = await instance.database;
    return await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}

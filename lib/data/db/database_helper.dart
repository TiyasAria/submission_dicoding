import 'package:reaturant_app/data/model/model.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static DatabaseHelper? _instance;

  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorite';

  Future<Database> _initializedDB() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurantapp.db',
      onCreate: (db, version) async {
        await db.execute('''
         CREATE TABLE $_tblFavorite (
            id TEXT PRIMARY KEY , 
            name TEXT , 
            description TEXT ,
            city TEXT , 
            pictureId TEXT , 
            rating DOUBLE  
         )''');
      },
      version: 1,
    );
    return db;
  }

//    for get database
  Future<Database?> get database async {
    _database ??= await _initializedDB();

    return _database;
  }

//    method for crud
  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblFavorite, restaurant.toJson());
  }

  Future<List<Restaurant>> getRestaurant() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblFavorite);
    return result.map((res) => Restaurant.fromJson(res)).toList();
  }

//get restaurant by id and remove it
  Future<Map> getRestaurantById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> result =
    await db!.query(_tblFavorite, where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  Future<void>  deleteRestaurant(String id) async {
    final db = await database ;
    await db!.delete(_tblFavorite , where:  'id = ?' , whereArgs:  [id]);
  }
}

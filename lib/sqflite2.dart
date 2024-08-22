// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class SqlDb2 {
//   static Database? _db;

//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await intialDb();
//       return _db;
//     } else {
//       return _db;
//     }
//   }

//   intialDb() async {
//     String databasePath = await getDatabasesPath();
//     String path = join(databasePath, 'cat.db');
//     Database mydb = await openDatabase(path, onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
//     return mydb;
//   }

//   _onUpgrade(Database db, int oldversion, int newversion) {
//     print("onUpgrade===========================");
//   }

//   _onCreate(Database db, int version) async {
//     await db.execute('''
// CREATE TABLE notes (
// id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
// text1 TEXT NOT NULL,
// text2 TEXT NOT NULL,
// text3 TEXT NOT NULL
// )
// ''');
//     print("Create DATABASE AND TABLE ===============================");
//   }
// //!readData
//   Future<List<Map>> readData(String sql) async {
//     Database? mydb = await db;
//     List<Map> response = await mydb!.rawQuery(sql);
//     return response;
//   }
// //!insertData
//   Future<int> insertData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawInsert(sql);
//     return response;
//   }
// //!updateData
//   Future<int> updateData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawUpdate(sql);
//     return response;
//   }
// //!deleteData
//   Future<int> deleteData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawDelete(sql);
//     return response;
//   }
// }
//?


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb2 {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
    }
    return _db;
  }
//
  Future<Database> initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'cat.db');
    return openDatabase(path, onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("Upgrading database from version $oldVersion to $newVersion");
    // Here you can add code to handle schema changes
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE notes (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  text1 TEXT NOT NULL,
  text2 TEXT NOT NULL,
  text3 TEXT NOT NULL
)
''');
    print("Created DATABASE AND TABLE");
  }
/////////////////////////////

  Future<List<Map<String, dynamic>>> readData(String sql, [List<dynamic>? arguments]) async {
    Database? mydb = await db;
    return mydb!.rawQuery(sql, arguments);
  }
////
  Future<int> insertData(String sql, [List<dynamic>? arguments]) async {
    Database? mydb = await db;
    return mydb!.rawInsert(sql, arguments);
  }
//
  Future<int> updateData(String sql, [List<dynamic>? arguments]) async {
    Database? mydb = await db;
    return mydb!.rawUpdate(sql, arguments);
  }
///
  Future<int> deleteData(String sql, [List<dynamic>? arguments]) async {
    Database? mydb = await db;
    return mydb!.rawDelete(sql, arguments);
  }
  /////////
  //! delete Data By Id
  Future<int> deleteDataById(int id) async {
  Database? mydb = await db;
  return mydb!.delete(
    'notes',
    where: 'id = ?',
    whereArgs: [id],
  );
}
///////////////
}

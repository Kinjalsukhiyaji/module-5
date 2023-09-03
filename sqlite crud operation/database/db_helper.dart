import 'package:module5/sqlite%20crud%20operation/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  //Database name
  static final String _dbName = 'tops.db';
  //Database version
  static int _dbVersion = 1;
  //Table name
  static final String _tableUsers = 'users';
  //Column name
  static final String _id = 'id';
  static final String _name = 'name';
  static final String _email = 'email';
  static final String _age = 'age';
  static final String _date = 'date';

  static Database? _database;

  Future<Database?> getDatabase() async {
    if(_database == null) {
      _database = await createDatabase();
    }
    return _database;
  }

  Future<Database?>createDatabase() async {
    var path = join(await getDatabasesPath(),_dbName);
    print('Database path: $path');
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db,version) {
        return db.execute('CREATE TABLE $_tableUsers('
            '$_id INTEGER PRIMARY KEY AUTOINCREMENT , '
            '$_name TEXT, '
            '$_email TEXT, '
            '$_age INTEGER, '
            '$_date INTEGER )');
        }
      );
  }
  Future<int>insert(User user) async {
    final db = await getDatabase();
    return await db!.insert(_tableUsers,user.toMap());
  }
  Future<int> update (User user) async {
    final db = await getDatabase();
    return await db!.update(_tableUsers,user.toMap(),where:'$_id = ?',whereArgs: [user.id]);
  }
  Future<List> getUserList() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> map = await db!.query(_tableUsers);
    return List.generate(map.length, (index) => User.fromMap(map[index])).toList();
  }
  Future<int> remove (int userId) async{
    final db = await getDatabase();
    return await db!.delete(_tableUsers,where: '$_id = ?',whereArgs: [userId]);
  }
}
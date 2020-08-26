import 'dart:io';
import 'package:path/path.dart';

//this plugin allows us to create and use an sqlite database
import 'package:sqflite/sqflite.dart';

// The path_provider plugin allows us to access the user directories on
// iOS and Android which is where we will have to store the SQLite database file.
import 'package:path_provider/path_provider.dart';
import "classes/Todo.dart";


/*
Now lets start by creating our own database abstraction layer. 
This new class will allow for easy access to our SQLite database. It will act as our data 
access object as well by providing functions to query for specific data models.
*/


class DBHelper {
  
  static final _dbName = "todo.db";
  static final _dbVersion = 2;

  static final tableTodos = 'todos';
  
  static final columnId = '_id';
  static final columnLabel = 'label';
  static final columnPriority = 'priority';
  static final columnIsDone = "isDone";


  // make this a singleton class
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _db;
  Future<Database> get database async {
    if (_db != null) return _db;
    // lazily instantiate the db the first time it is accessed
    _db = await _initDatabase();
    return _db;
  }
  
  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path,
        version: _dbVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableTodos (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnLabel TEXT NOT NULL,
            $columnPriority INT NOT NULL,
            $columnIsDone BOOLEAN NOT NULL
          )
          ''');
  }
  
  // Helper methods
  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // All of the rows are returned as a list of maps, where each map is 
  // a key-value list of columns.
  Future<List<Todo>> queryAllRows(String tableName) async {
    Database db = await instance.database;
    List<Map<String,dynamic>> listTodos = await db.query(tableName);

    List<Todo> res = new List<Todo>(); 
    listTodos.forEach((element) {
      
      res.add(Todo.fromMap(element));

    });

    return res; 
  }


  // All of the rows are returned as a list of maps, where each map is 
  // a key-value list of columns.
  Future<Todo> queryRowById(String tableName, int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> res = await db.rawQuery('SELECT * FROM $tableName where id = $id');
    return Todo.fromMap(res[0]);
  }


  // We are assuming here that the id column in the map is set. The other 
  // column values will be used to update the row.
  Future<int> update(String tableName,Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is 
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String tableName, int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }


}
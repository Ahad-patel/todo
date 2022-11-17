

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/notes_model.dart';




class DBProvider {
  static const String tableNotes = 'Notes';


  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnSubtitle = 'subtitle';
  static const String columnTime = 'time';






  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  /*
  create db for fav images
  */
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print("database storage path android $documentsDirectory");
    String path = join(documentsDirectory.path, "api.db");
    return await openDatabase(
        path,
        version: 1,

        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          log("database version = $version");
          await db.execute(
              "CREATE TABLE $tableNotes ("
                  "$columnId INTEGER PRIMARY KEY,"
                  "$columnTitle TEXT,"
                  "$columnSubtitle TEXT,"
                  "$columnTime INTEGER" ")"
          );

          },


      //   /// on upgrading database table
      // onUpgrade: (Database db, int oldVersion, int newVersion) async {
      //
      //     if(oldVersion < newVersion) {
      //
      //       await db.execute("DROP TABLE IF EXISTS $tableNotes");
      //
      //     } //if condition
      //  },

      // onDowngrade: (Database db, int oldVersion, int newVersion) async {
      //   if(true) {
      //
      //   }
      //
      // }


    );
  }

  /* insert data */
  addDataIntoNotes(Notes response) async {
    final db = await database;
      try{
        var raw = await db.rawInsert(
            "INSERT Into $tableNotes ($columnId,$columnTitle,$columnSubtitle,$columnTime)"
                " VALUES (?,?,?,?)",
            [response.id,response.title,response.subtitle,response.time]);
        return raw;
      }catch(e){
        var raw = await db.rawUpdate(
            'UPDATE $tableNotes SET $columnTitle = ? $columnSubtitle = ? $columnTime = ?  WHERE $columnId = ?',
            [response.title,response.subtitle,response.time, response.id]);
        return raw;

      }
  }



  /* update data into db */

  updateNotes(Notes response) async {
    final db = await database;
    try{
      var raw = await db.rawUpdate(
          'UPDATE $tableNotes SET $columnTitle = ? $columnSubtitle = ? $columnTime = ?  WHERE $columnId = ?',
          [response.title,response.subtitle,response.time, response.id]);
      return raw;

    }catch(e){
      // showMyDialog("$e");
    }
  }



  /* fetch data from db */
  Future<List<Notes>> getDataFromNotes() async {
    final db = await database;
    var res = await db.query(tableNotes);
    var list =
    res.isNotEmpty ? res.map((c) => Notes.fromJson(c)).toList() : List<Notes>.empty();
    return list;
  }



  /* delete data from db  */
  Future removeNote(int? id) async {
    final db = await database;
    await db.rawQuery('DELETE FROM $tableNotes WHERE $columnId = ?',
        [id]);
  }




  /* check  table exits or not */
   resTableIsEmpty()async{
    var db = await database;
    int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableNotes'));
    log("$count");
    return count==0;
  }




  clearDB()async{
      var db = await database;
      await db.rawQuery('DELETE FROM $tableNotes');
 }

closedb() async {
   final db=await database;
   _database = null;
     await db.close();
}
opendb() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, "api.db");
  await openDatabase(
    path ,
    version: 1,
    onOpen: (db) {},);
}
}


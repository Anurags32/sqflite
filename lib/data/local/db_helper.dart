import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' ;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
// singleton mean maultiple intanse banna band ho gaya
  DBHelper._();
  static final DBHelper getInstance = DBHelper._();
  static final String Table_Note = "note";
  static final String Column_Note_Sn = "s_no";
  static final String Column_Note_title = "title";
  static final String Column_Note_desc = "desc";
//  static DBHelper getInstance() {
//     return DBHelper._();
//   }

// database intanse
  Database? mydb;

// condition lagi hai pahle hame chek kare ge ki database hai ya nahi hai to open kar do other wise create kar do

  Future<Database> getDB() async {
    mydb ??= await openDB();
    return mydb!;

    // alternate tarika

    // if (mydb != null) {
    //   return mydb!;
    // } else {
    //   mydb = await openDB();
    //   return mydb!;
    // }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDir.path, "noteDb.db");
// jab ham function ka nam nahi dete like Function(db,db.path) ayese karte hai to use anonimous funtion bolte hai use
    return await openDatabase(dbPath, onCreate: (db, version) {
//   create all table
// jab ham scema chnage karna padega tabhi version chnage ho ga

      db.execute(
          "create table $Table_Note ($Column_Note_Sn integer primary key autoincrement,$Column_Note_title text $Column_Note_desc text)");
    }, version: 1);
  }

// all queries
// insertion

Future<bool> addNote({required String mTitle, required String mDesc})async{
var db = await getDB();
int rowsEffected =await db.insert(Table_Note, {Column_Note_title:mTitle,Column_Note_desc:mDesc});
return rowsEffected>0;
}
// reding all data
Future<List<Map<String, dynamic>>> getallnotes()async{
  var db = await getDB();
  // select * from note
 List<Map<String,dynamic>> mData = await db.query(Table_Note);
 return mData;
}
  
}

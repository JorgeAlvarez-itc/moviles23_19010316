import 'dart:io';
import 'package:prueba1/models/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
class DatabaseHelper{
  
  static final nameDB= 'SOCIALDB';
  static final versionDB=1;

  static Database? _database;

  Future<Database> get database async{
    if(_database!=null) return _database!;
    return _database= await _initDatabase();
  }

  _initDatabase() async{
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB=join(folder.path,nameDB);
    await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) async{
    String query='''CREATE TABLE tblPost (
     idPost INTEGER PRIMARY KEY,
     descPost VARCHAR(200), 
     datePost DATE)''';
    db.execute(query);
  }

  Future<int> ISERT(String tblName,Map<String,dynamic> data) async{
    var conexion= await database;
    return await conexion.insert(tblName, data);
  }
  Future<int> UPDATE(String tblName,Map<String,dynamic> data) async{
    var conexion= await database;
    return await conexion.update(
      tblName,
      data,
      where:'idPost=?',
      whereArgs:[data['idPost']]
    );
  }
  Future<int> DELETE(String tblName,int idPost) async{
    var conexion= await database;
    return await conexion.delete(
      tblName,
      where: 'idPost',
      whereArgs: [idPost],
    );
  }
  Future <List<PostModel>> GETALLPOST() async{
    var conexion= await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }
}
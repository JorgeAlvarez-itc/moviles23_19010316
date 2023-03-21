import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:prueba1/models/post_model.dart';
import 'package:prueba1/models/evento_model.dart';
import 'package:path_provider/path_provider.dart';
class DatabaseHelper{
  
  static final nameDB= 'SOCIALDB';
  static final versionDB=3;

  static Database? _database;

  Future<Database> get database async{
    if(_database!=null) return _database!;
    return _database= await _initDatabase();
  }

  _initDatabase() async{
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB=join(folder.path,nameDB);
    return await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) async{
      String query = '''
      CREATE TABLE tblPost (
        idPost INTEGER PRIMARY KEY,
        descPost VARCHAR(200),
        datePost DATE
      );''';
     await db.execute(query);
     String query2='''
      CREATE TABLE tblEvento (
        idEvento INTEGER PRIMARY KEY,
        dscEvento VARCHAR(200),
        fechaEvento DATE,
        completado BOOLEAN
      );
    ''';
    await db.execute(query2);
  }

  Future<int> INSERT(String tblName,Map<String,dynamic> data) async{
    var conexion= await database;
    print(data);
    return await conexion.insert(tblName, data);
  }
  Future<int> UPDATE(String tblName, Map<String, dynamic> data, String idColumnName) async {
    var conexion = await database;
    return await conexion.update(
      tblName,
      data,
      where: '$idColumnName = ?',
      whereArgs: [data[idColumnName]],
    );
  }

  Future<int> DELETE(String tblName, int id, String idColumnName) async {
    var conexion = await database;
    return await conexion.delete(
      tblName,
      where: '$idColumnName = ?',
      whereArgs: [id],
    );
  }

  Future <List<PostModel>> GETALLPOST() async{
    var conexion= await database;
    var result = await conexion.query('tblPost');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<List<EventoModel>> getAllEventos() async {
    var conexion = await database;
    var result = await conexion.query('tblEvento');
    return result.map((evento) => EventoModel.fromMap(evento)).toList();
  }

 Future<List<EventoModel>> getEventsForDay(String fecha) async {
  var conexion = await database;
  var query="SELECT * FROM tblEvento where fechaEvento=?";
  var result = await conexion.rawQuery(query,[fecha]);
  List<EventoModel> eventos = [];
  if (result != null && result.isNotEmpty) {
    eventos = result.map((evento) => EventoModel.fromMap(evento)).toList();
  }
  return eventos;
}

}
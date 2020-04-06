import 'dart:io';
import 'package:path/path.dart';
import 'package:qr_reader/src/models/scan_model.dart';
export 'package:qr_reader/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBprovider{
  static Database _database;
  static DBprovider db = DBprovider._private();
  // Patron singleton
  DBprovider._private();

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }else{
      _database = await initDB();
      return _database;
    }
  }

  Future<Database> initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    final path = join(docDir.path,'ScansDB.db');
    return openDatabase(
      path,
      version: 2,
      onOpen: (db){},
      onCreate: (Database db,int version) async{
        await db.execute('CREATE TABLE scans( '
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT )'
        );
      },
    );
  }

  Future<int> insertRawScan(ScanModel scans) async{
    final db = await database;
    final result = await db.rawInsert(
      "INSERT INTO scans (id, tipo, valor) "
      "VALUES (${scans.id},'${scans.tipo}','${scans.valor}')"
      );
    return result;
  }

  Future<int> insertScan(ScanModel scans) async{
    final db = await database;
    final result = await db.insert('scans', scans.toJson());
    return result;
  }

  Future<ScanModel> getById(int id) async{
    final db = await database;
    final result = await db.query('scans',where: 'id = ?',whereArgs: [id]);
    return result.isNotEmpty  ? ScanModel.fromJsonMap(result.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async{
    final db = await database;
    final result = await db.query('scans');
    List<ScanModel> listOfData = 
      result.isNotEmpty ? result.map((c)=>ScanModel.fromJsonMap(c)).toList() : [];
    return listOfData;
  }

  Future<List<ScanModel>> getScansByType(String tipo) async{
    final db = await database;
    final result = await db.rawQuery("SELECT * FROM scans WHERE tipo = '$tipo' ");
    List<ScanModel> listOfData = 
      result.isNotEmpty ? result.map((c)=>ScanModel.fromJsonMap(c)).toList() : [];
    return listOfData;
  }

  Future<int> updateScansById(ScanModel newScan) async {
    final db = await database;
    final result = await db.update('scans', newScan.toJson(), where: 'id = ?',whereArgs: [newScan.id]);
    return result;
  }

  Future<int> deleteScanById(int id) async{
    final db = await database;
    final result = await db.delete('scans',where: 'id = ?',whereArgs: [id]);
    return result;
  }

  Future<int> deleteAllScan() async{
    final db = await database;
    final result = await db.rawDelete("DELETE FROM scans");
    return result;
  }
}
import 'dart:io';

import 'package:qrscannerapp/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
    static Database? _database;
    static final DBProvider db = DBProvider._();
    
    DBProvider._();

    Future<Database> get database async {
      if(_database != null){
        return _database!;
      }

      _database = await initDB();
      return _database!; 
    }

    initDB() async {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      final path = join(documentsDirectory.path, 'ScansDB.db');

      return await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE Scans ('
            ' id INTEGER PRIMARY KEY,'
            ' tipo TEXT,'
            ' valor TEXT'
            ')'
          );
        },
      );
    }

    // Crear Registros en la base de datos

    nuevoScanRaw(ScanModel nuevoScan) async {
      // metodo con consulta SQL clasica
      
      final db = await database;

      final res = await db.rawInsert(
        "INSERT INTO Scans (id, tipo, valor) "
        "VALUES (${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}')"
      );

      return res;
    }

    nuevoScan (ScanModel nuevoScan) async {
      // metodo mas sencillo usando funciones del paquete SQFLite

      final db = await database;

      final res = await db.insert('Scans', nuevoScan.toJson());

      return res;
    }

    //SELECT - obtener informacion de la DB
    Future<ScanModel?> getScanId(int id) async {
      final db = await database;
      final res = await db.query(
        'Scans',
        where: 'id=?',
        whereArgs: [id]
      );

      return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
    }

    Future<List<ScanModel>?> getAllScans() async {
      final db = await database;
      final res = await db.query("Scans");
      
      List<ScanModel>? list = res.isEmpty? 
        res.map((e) => ScanModel.fromJson(e)).toList() 
        : null;
      
      return list;
    }

    Future<List<ScanModel>?> getScansPorTipo(String tipo) async {
      final db = await database;
      final res = await db.query(
        "Scans",
        where: 'tipo=?',
        whereArgs: [tipo]
      );
      
      List<ScanModel>? list = res.isEmpty? 
        res.map((e) => ScanModel.fromJson(e)).toList() 
        : null;
      
      return list;
    }

    //Actualizar registros
    Future<int> updateScan(ScanModel nuevoScan) async {
      final db = await database;
      final res = await db.update(
        'Scans',
        nuevoScan.toJson(),
        where: 'id=?',
        whereArgs: [nuevoScan.id]
      );

      return res;
    }

    //Eliminar registros
    Future<int> deleteScan(int id) async {
      final db = await database;
      final res = await db.delete(
        'Scans',
        where: 'id=?',
        whereArgs: [id],
      );

      return res;
    }
}
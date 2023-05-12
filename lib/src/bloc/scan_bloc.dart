

import 'dart:async';

import 'package:qrscannerapp/src/bloc/validator.dart';
import 'package:qrscannerapp/src/models/scan_model.dart';
import 'package:qrscannerapp/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //obtener los scans de la base de datos
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>?>.broadcast();

  Stream<List<ScanModel>?> get scansStreamGeo => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>?> get scansStreamHttp => _scansController.stream.transform(validarHttp);

  dispose() {
    _scansController.close();
  }

  obtenerScans() async {
    _scansController.sink.add( await DBProvider.db.getAllScans());
  }

  agregarScan(ScanModel scan)async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

}
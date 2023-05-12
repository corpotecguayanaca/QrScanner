

import 'dart:async';

import 'package:qrscannerapp/src/models/scan_model.dart';

mixin Validators{
  final validarGeo = StreamTransformer<List<ScanModel>?,List<ScanModel>?>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans!.where((element) => element.tipo! == 'geo').toList();

      sink.add(geoScans);
    },
  );

  final validarHttp = StreamTransformer<List<ScanModel>?,List<ScanModel>?>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans!.where((element) => element.tipo! == 'http').toList();

      sink.add(geoScans);
    },
  );
}
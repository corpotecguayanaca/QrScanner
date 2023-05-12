import 'dart:core';

import 'package:flutter/material.dart';
import 'package:qrscannerapp/src/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';

class CoordenadasPage extends StatefulWidget {


  const CoordenadasPage({super.key});

  @override
  State<CoordenadasPage> createState() => _CoordenadasPageState();
}

class _CoordenadasPageState extends State<CoordenadasPage> {
  final MapController mapCtrl = MapController();

  int currentIndex = 0;

  final List<String> estilos = [
    'mapbox/streets-v12',
    'mapbox/outdoors-v12',
    'mapbox/dark-v11',
    'mapbox/satellite-v9',
    'mapbox/satellite-streets-v12'
  ];
   
  String currentStyle = 'mapbox/streets-v12';


  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Coordenadas QR"),
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: TextStyle( 
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary,),
        actions: [
          IconButton(
            onPressed: (){
              mapCtrl.move(scan.getLatLng(), 15);
            }, 
            icon: const Icon(Icons.my_location,),
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapCtrl,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15.0
      ),
      children: [
        _crearMapa(),
        _crearMarcador(scan),
      ],
    );
  }

  Widget _crearMapa() {
    return TileLayer(
      urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'id': currentStyle,
        'accessToken': 'pk.eyJ1IjoibGptYXJxdWV6eiIsImEiOiJjbGhrdTJ5MXAwZGdwM2ZxeGkwNGRsb3RxIn0.54jcCCU0gePhL2BWwt2b_Q',
      },
    );
  }

  Widget _crearMarcador(ScanModel scan) {
    return MarkerLayer(
      markers: [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(), 
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 50.0,
              color: Theme.of(context).primaryColor,
            ),
          )
        ),
      ],
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          currentIndex++;
          if(currentIndex == estilos.length) currentIndex = 0;
          currentStyle = estilos[currentIndex];
        });
      },
      shape: const CircleBorder(),
      child: const Icon(Icons.layers, size: 32.0,),
    );
  }
}
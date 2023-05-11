import 'package:flutter/material.dart';
import 'package:qrscannerapp/src/pages/direcciones_page.dart';
import 'package:qrscannerapp/src/pages/home_page.dart';
import 'package:qrscannerapp/src/pages/mapas_page.dart';
import 'package:qrscannerapp/src/pages/scan_qr_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRScanner',
      initialRoute: 'home',
      debugShowCheckedModeBanner: false,
      routes: {
        'home': (context) => HomePage(),
        'mapas': (context) => MapasPage(),
        'direcciones':(context) => DireccionesPage(),
        'scan':(context) => ScanQRPage(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
      ),
    );
  }
}
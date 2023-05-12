import 'package:flutter/material.dart';
import 'package:qrscannerapp/src/bloc/scan_bloc.dart';
import 'package:qrscannerapp/src/models/scan_model.dart';
import 'package:qrscannerapp/src/pages/direcciones_page.dart';
import 'package:qrscannerapp/src/pages/mapas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //https://ljmarquezz.github.io
  //geo:8.279876,-62.760479

  final scansBloc = ScansBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    String? codigoLeido = ModalRoute.of(context)!.settings.arguments as String?;

    if(codigoLeido != null) {
      final scan = ScanModel(valor: codigoLeido);
      scansBloc.agregarScan(scan);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("QRScanner"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: TextStyle( 
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
        ),

        actions: [
          IconButton(
            onPressed: (){
              scansBloc.borrarScanTodos();
            }, 
            icon: Icon(Icons.delete_forever, color: Theme.of(context).colorScheme.onPrimary,))
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNAvigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'scan'),
        child: const Icon(Icons.filter_center_focus),
      ),
    );
  }

  Widget _createBottomNAvigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: "Mapas",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.computer),
          label: "Direcciones",
        ),
      ],
    );
  }

  Widget _callPage(int paginaActual) {
    switch(paginaActual) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default: return MapasPage();
    }
  }

}
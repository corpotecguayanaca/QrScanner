import 'package:flutter/material.dart';
import 'package:qrscannerapp/src/bloc/scan_bloc.dart';
import 'package:qrscannerapp/src/models/scan_model.dart';
import 'package:qrscannerapp/src/utils/utils.dart' as utils;


class DireccionesPage extends StatelessWidget {
  DireccionesPage({super.key});

  final scansBloc = ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();
    return StreamBuilder(
      stream: scansBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final scans = snapshot.data! as List<ScanModel>?;
        if (scans!.isEmpty) {
          return const Center(
            child: Text("No hay Registros"),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: ((context, index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.redAccent,
              ),
              onDismissed: (direction) => scansBloc.borrarScan(scans[index].id!),
              child: ListTile(
                leading: Icon(
                  Icons.cloud,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scans[index].valor!),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () => utils.abrirScan(context, scans[index]),
              ),
            );
          }),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qrscannerapp/src/providers/db_provider.dart';
import 'package:qrscannerapp/src/models/scan_model.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBProvider.db.getAllScans(),
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
              onDismissed: (direction) => DBProvider.db.deleteScan(scans[index].id!),
              child: ListTile(
                leading: Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scans[index].valor!),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

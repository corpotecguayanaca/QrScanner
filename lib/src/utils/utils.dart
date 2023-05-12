import 'package:qrscannerapp/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

abrirScan(BuildContext context, ScanModel scan) async {
  if (scan.tipo! == "http") {
    String host = scan.valor!.substring(8);
    final url = Uri(scheme: 'https', host: host);

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  } else {
    Navigator.pushNamed(context, 'coordenadas', arguments: scan);
  }
}

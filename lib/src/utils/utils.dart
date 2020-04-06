import 'package:flutter/cupertino.dart';
import 'package:qr_reader/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(ScanModel scan,BuildContext context) async {
  if(scan.tipo.contains('http')){
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'Could not launch ${scan.valor}';
    }
  }else{
    Navigator.pushNamed(context, 'deploymap', arguments: scan);
  }
}
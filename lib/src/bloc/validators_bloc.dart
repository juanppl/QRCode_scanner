
import 'dart:async';

import 'package:qr_reader/src/models/scan_model.dart';

class Validators {

  final validateGeo = StreamTransformer< List<ScanModel> , List<ScanModel> >.fromHandlers(
    handleData: (scan,sink){
      final geoScans = scan.where((s)=>s.tipo == 'geo').toList();
      sink.add(geoScans);
    }
  );

  final validateHttp = StreamTransformer< List<ScanModel> , List<ScanModel> >.fromHandlers(
    handleData: (scan,sink){
      final geoScans = scan.where((s)=>s.tipo == 'http').toList();
      sink.add(geoScans);
    }
  );
  
}
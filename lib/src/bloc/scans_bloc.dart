import 'dart:async';

import 'package:qr_reader/src/bloc/validators_bloc.dart';
import 'package:qr_reader/src/providers/db_provider.dart';

class ScansBloc with Validators{

  static final _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    getScans();
  }
  
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scanStream => _scansController.stream.transform(validateGeo);
  Stream<List<ScanModel>> get scanStreamHttp => _scansController.stream.transform(validateHttp);

  @override
  dispose(){
    _scansController?.close();
  }

  addScan(ScanModel scan) async {
    await DBprovider.db.insertScan(scan);
    getScans();
  }

  getScans() async{
    _scansController.sink.add(await DBprovider.db.getAllScans());
  }

  deleteScansById(int id) async {
    await DBprovider.db.deleteScanById(id);
    getScans();
  }

  deleteAllScans() async {
    await DBprovider.db.deleteAllScan();
    getScans();
  }
}
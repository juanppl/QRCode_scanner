import 'package:latlong/latlong.dart';
class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }){
    if(valor.contains('http')){
      tipo = 'http';
    }else{
      tipo = 'geo';
    }
  }

  /* ScanModel.fromJsonMap(Map<String,dynamic> json){
    id = json['id'];
    tipo = json['tipo'];
    valor = json['valor'];
  } */

  factory ScanModel.fromJsonMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );

  Map<String,dynamic> toJson(){
    return {
      "id": id,
      "tipo":tipo,
      "valor":valor
    };
  }

  LatLng getLatLng(){
    final latlng = valor.substring(4).split(',');
    final lat = double.parse(latlng[0]) ;
    final long = double.parse(latlng[1]);
    return LatLng(lat,long);

  }
}
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_reader/src/models/scan_model.dart';

class MapDeployPage extends StatefulWidget{
  @override
  _MapDeployPageState createState() => _MapDeployPageState();
}

class _MapDeployPageState extends State<MapDeployPage> {
  final MapController mapController = new MapController();

  String mapType = 'streets';

  @override
  Widget build(BuildContext context){
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Location'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: (){
              mapController.move(scan.getLatLng(), 15);
            },
          ),
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _changeMap(context),
    );
  }

  Widget _changeMap(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if (mapType == 'streets'){
          mapType = 'dark';
        }else if(mapType == 'dark'){
          mapType = 'light';
        }else if(mapType == 'light'){
          mapType = 'outdoors';
        }else if(mapType == 'outdoors'){
          mapType = 'satellite';
        }else{
          mapType = 'streets';
        }
        setState(() {
          
        });
      }
    );
  }

  _createFlutterMap(ScanModel scan){
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15.0,
      ),
      layers:[ 
        _createMap(),
        _createMarkers(scan),
      ],
    );
  }

  _createMap(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoianVhbnBwbDEyIiwiYSI6ImNrNmwxM3B4YjA3M2gza24wYnBueXRoenYifQ.WyEr3PLdbW5Erdh7fI5Qfg',
        'id':'mapbox.$mapType'
      }
    );
  }

  _createMarkers(ScanModel scan){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          point: scan.getLatLng(),
          builder: (BuildContext context){
            return Container(
              child: Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
                size: 60.0,
              ),
            );
          }
        ),
      ]
    );
  }
}
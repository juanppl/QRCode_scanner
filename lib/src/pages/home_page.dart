import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_reader/src/bloc/scans_bloc.dart';
import 'package:qr_reader/src/models/scan_model.dart';
import 'package:qr_reader/src/pages/address_page.dart';
import 'package:qr_reader/src/pages/maps_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_reader/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){
              scansBloc.deleteAllScans();
            },
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBNB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.filter_center_focus),
        onPressed:()=> _scanQR(context),
      ),
    );
  }

  _scanQR(BuildContext context) async{
    //String fResult = 'https://fernando-herrera.com/';
    String fResult ;
    try{
      fResult = await BarcodeScanner.scan();
    }catch(e){
      fResult = e.toString();
    }
    if(fResult != null){
      final scan = ScanModel(valor: fResult);
      scansBloc.addScan(scan);
      if(Platform.isIOS){
        Future.delayed(Duration(milliseconds: 750),(){
          utils.launchURL(scan,context);
        });
      }else{
        utils.launchURL(scan,context);
      }
    }
  }
  
  Widget _createBNB(){
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items:[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Map')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Address')
        )
      ]
    );
  }

  Widget _callPage(int actualPage){
    switch (actualPage) {
      case 0:
        return MapsPage();
        break;
      case 1:
        return AddressPage();
        break;
      default:
        return MapsPage();
    }
  }
}
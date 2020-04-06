import 'package:flutter/material.dart';
import 'package:qr_reader/src/pages/address_page.dart';
import 'package:qr_reader/src/pages/home_page.dart';
import 'package:qr_reader/src/pages/map_deploy_page.dart';
import 'package:qr_reader/src/pages/maps_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
      initialRoute: 'home',
      routes: {
        'home':(BuildContext context)=> HomePage(),
        'address':(BuildContext context)=> AddressPage(),
        'maps':(BuildContext context)=> MapsPage(),
        'deploymap':(BuildContext context)=> MapDeployPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
    );
  }
}
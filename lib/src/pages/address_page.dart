import 'package:flutter/material.dart';
import 'package:qr_reader/src/bloc/scans_bloc.dart';
import 'package:qr_reader/src/models/scan_model.dart';
import 'package:qr_reader/src/utils/utils.dart' as utils;

class AddressPage extends StatelessWidget {

  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    scansBloc.getScans();
    return StreamBuilder(
      stream: scansBloc.scanStreamHttp,
      builder: (BuildContext context,AsyncSnapshot<List<ScanModel>> snapshot ){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          final scan = snapshot.data;
          if(scan.length == 0){
            return Center(child: Text('No data available'),);
          }else{
            return ListView.builder(
              itemCount: scan.length,
              itemBuilder: (BuildContext context, int i){
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction){
                    scansBloc.deleteScansById(scan[i].id);
                  },
                  child: ListTile(
                    leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor,),
                    title: Text(scan[i].valor),
                    trailing: Icon(Icons.arrow_right,color: Colors.grey,),
                    onTap: (){
                      utils.launchURL(scan[i],context);
                    },
                  ),
                );
              }
            );
          }
        }
      }
    );
  }
}
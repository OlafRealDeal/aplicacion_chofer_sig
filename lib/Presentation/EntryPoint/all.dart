import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/Business/EntryPointBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/EntryPoint.dart';
import 'package:aplicacion_chofer_sig/Presentation/Layouts/header.dart';
import 'package:aplicacion_chofer_sig/Presentation/EntryPoint/edit.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/dialog.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';
import 'package:aplicacion_chofer_sig/route_generator.dart';

import 'package:aplicacion_chofer_sig/env.dart';

class AllEntryPoint extends StatefulWidget{
  const AllEntryPoint({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __AllEntryPointState();
  }

}

class __AllEntryPointState extends State<AllEntryPoint>{

  EntryPointBusiness entrypointBusiness=new EntryPointBusiness();
  List<Widget> listaDeCards=List.generate(0, (index) =>SizedBox(height: 1,));

  @override
  void initState() {
    super.initState();
    loadEntryPoint(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Style().backgroundColor(),
      appBar: headerAppBar(context),
      drawer: SideNav(),
      floatingActionButton:  FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context,entrypointCreateRoute());
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.black
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              //appBackground(),
              SingleChildScrollView(
                child: todo(context),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget todo(BuildContext context) {
    return
      SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                //searchBar(context),
                listOfEntryPoint()
              ],
            ),
          )
      );

  }

  void loadEntryPoint(BuildContext context) async{

    await Future.delayed(Duration(milliseconds: 10));
    showLoadingIndicator(context,'');
    DataResponse dataResponse=await entrypointBusiness.indexParamLatLong('1');
    List<EntryPoint> items=dataResponse.data;
    setState(() {
      hideOpenDialog(context);
      items.forEach((item) {
        var c = cardEntryPoint(context,item);
        listaDeCards.add(c);
      });
    });
  }

  Widget listOfEntryPoint() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listaDeCards.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index) {
          return listaDeCards[index];
        });
  }

Widget cardEntryPoint(BuildContext context,EntryPoint entrypoint){
    return Card(
      child:Container(
        height: 200,
        color: Style().backgroundColor(),
        child: Row(
          children: [
            Expanded(
              child:Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Text(entrypoint.lat),
                                  Text(entrypoint.long),
                                  Text(entrypoint.bus_route_id),

                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            color: Style().primaryColor(),
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushNamed(context, entrypointEditRoute(),arguments: EditEntryPointArguments(entrypoint));
                            },
                          ),
                          SizedBox(width: 8,),
                          IconButton(
                            color: Style().primaryColor(),
                            icon: const Icon(Icons.delete),
                            onPressed: () async{
                              showAlertDialogOptions(context,"Delete EntryPoint","¿Are you sure?",
                                      () async{
                                await deleteEntryPoint(entrypoint);
                              });
                            },
                          ),
                          SizedBox(width: 8,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex:8 ,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
    );
  }

  Future<void> deleteEntryPoint(EntryPoint entrypoint) async{
    showLoadingIndicator(context,'Deleting EntryPoint...');
    DataResponse dataResponse=await entrypointBusiness.delete(entrypoint.id);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context, entrypointAllRoute());
      }else{
        showAlertDialog(context, "Error deleting EntryPoint", dataResponse.message);
      }
    });
  }

}


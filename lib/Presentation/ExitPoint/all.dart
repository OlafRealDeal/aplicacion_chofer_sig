import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/Business/ExitPointBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/ExitPoint.dart';
import 'package:aplicacion_chofer_sig/Presentation/Layouts/header.dart';
import 'package:aplicacion_chofer_sig/Presentation/ExitPoint/edit.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/dialog.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';
import 'package:aplicacion_chofer_sig/route_generator.dart';

import 'package:aplicacion_chofer_sig/env.dart';

class AllExitPoint extends StatefulWidget{
  const AllExitPoint({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __AllExitPointState();
  }

}

class __AllExitPointState extends State<AllExitPoint>{

  ExitPointBusiness exitpointBusiness=new ExitPointBusiness();
  List<Widget> listaDeCards=List.generate(0, (index) =>SizedBox(height: 1,));

  @override
  void initState() {
    super.initState();
    loadExitPoint(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Style().backgroundColor(),
      appBar: headerAppBar(context),
      drawer: SideNav(),
      floatingActionButton:  FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context,exitpointCreateRoute());
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
                listOfExitPoint()
              ],
            ),
          )
      );

  }

  void loadExitPoint(BuildContext context) async{

    await Future.delayed(Duration(milliseconds: 10));
    showLoadingIndicator(context,'');
    DataResponse dataResponse=await exitpointBusiness.index();
    List<ExitPoint> items=dataResponse.data;
    setState(() {
      hideOpenDialog(context);
      items.forEach((item) {
        var c = cardExitPoint(context,item);
        listaDeCards.add(c);
      });
    });
  }

  Widget listOfExitPoint() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listaDeCards.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index) {
          return listaDeCards[index];
        });
  }

Widget cardExitPoint(BuildContext context,ExitPoint exitpoint){
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
                                  Text(exitpoint.lat),
                                  Text(exitpoint.long),
                                  Text(exitpoint.bus_route_id),

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
                              Navigator.pushNamed(context, exitpointEditRoute(),arguments: EditExitPointArguments(exitpoint));
                            },
                          ),
                          SizedBox(width: 8,),
                          IconButton(
                            color: Style().primaryColor(),
                            icon: const Icon(Icons.delete),
                            onPressed: () async{
                              showAlertDialogOptions(context,"Delete ExitPoint","¿Are you sure?",
                                      () async{
                                await deleteExitPoint(exitpoint);
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

  Future<void> deleteExitPoint(ExitPoint exitpoint) async{
    showLoadingIndicator(context,'Deleting ExitPoint...');
    DataResponse dataResponse=await exitpointBusiness.delete(exitpoint.id);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context, exitpointAllRoute());
      }else{
        showAlertDialog(context, "Error deleting ExitPoint", dataResponse.message);
      }
    });
  }

}


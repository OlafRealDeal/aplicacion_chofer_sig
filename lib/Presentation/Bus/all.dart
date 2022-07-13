import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/Business/BusBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/Bus.dart';
import 'package:aplicacion_chofer_sig/Presentation/Layouts/header.dart';
import 'package:aplicacion_chofer_sig/Presentation/Bus/edit.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/dialog.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';
import 'package:aplicacion_chofer_sig/route_generator.dart';

import 'package:aplicacion_chofer_sig/env.dart';

class AllBus extends StatefulWidget{
  const AllBus({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __AllBusState();
  }

}

class __AllBusState extends State<AllBus>{

  BusBusiness busBusiness=new BusBusiness();
  List<Widget> listaDeCards=List.generate(0, (index) =>SizedBox(height: 1,));

  @override
  void initState() {
    super.initState();
    loadBus(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Style().backgroundColor(),
      appBar: headerAppBar(context),
      drawer: SideNav(),
      floatingActionButton:  FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context,busCreateRoute());
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
                listOfBus()
              ],
            ),
          )
      );

  }

  void loadBus(BuildContext context) async{

    await Future.delayed(Duration(milliseconds: 10));
    showLoadingIndicator(context,'');
    DataResponse dataResponse=await busBusiness.index();
    List<Bus> items=dataResponse.data;
    setState(() {
      hideOpenDialog(context);
      items.forEach((item) {
        var c = cardBus(context,item);
        listaDeCards.add(c);
      });
    });
  }

  Widget listOfBus() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listaDeCards.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index) {
          return listaDeCards[index];
        });
  }

Widget cardBus(BuildContext context,Bus bus){
    return Card(
      child:Container(
        height: 750,
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
                                  Text(
                                'Placa : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                                  Text(bus.placa),
                                  Text(
                                'Modelo : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                                  Text(bus.modelo),
                                  Text(
                                'Cantidad de Asientos : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                                  Text(bus.cantidad_asientos),
                                  Text(
                                'Fecha de Asignacion : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                                  Text(bus.fecha_asignacion),
                                  Text(
                                'Fecha de Baja : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                                  Text(bus.fecha_baja),
                                  Text(
                                'Interno : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                                  Text(bus.numero_interno),
                                  Text(
                                'Esta en Recorrido? : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                                  if(bus.esta_en_recorrido.toString() == '0')
                                  Text('No'),
                                  if(bus.esta_en_recorrido.toString() == '1')
                                  Text('Si'),
                                  
                                  Text(
                                'Id de Usuario : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                                  Text(bus.user_id),
                                  Text(
                                'Ruta del Bus : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                               if(bus.bus_route_id.toString() == '1')
                              Text('Linea 1'),
                               if(bus.bus_route_id.toString() == '2')
                              Text('Linea 2'),
                               if(bus.bus_route_id.toString() == '3')
                              Text('Linea 5'),
                               if(bus.bus_route_id.toString() == '4')
                              Text('Linea 8'),
                               if(bus.bus_route_id.toString() == '5')
                              Text('Linea 9'),
                               if(bus.bus_route_id.toString() == '6')
                              Text('Linea 10'),
                               if(bus.bus_route_id.toString() == '7')
                              Text('Linea 11'),
                               if(bus.bus_route_id.toString() == '8')
                              Text('Linea 16'),
                               if(bus.bus_route_id.toString() == '9')
                              Text('Linea 17'),
                               if(bus.bus_route_id.toString() == '10')
                              Text('Linea 18'),
                              

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
                              Navigator.pushNamed(context, busEditRoute(),arguments: EditBusArguments(bus));
                            },
                          ),
                          SizedBox(width: 8,),
                          IconButton(
                            color: Style().primaryColor(),
                            icon: const Icon(Icons.delete),
                            onPressed: () async{
                              showAlertDialogOptions(context,"Delete Bus","¿Are you sure?",
                                      () async{
                                await deleteBus(bus);
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

  Future<void> deleteBus(Bus bus) async{
    showLoadingIndicator(context,'Deleting Bus...');
    DataResponse dataResponse=await busBusiness.delete(bus.id);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context, busAllRoute());
      }else{
        showAlertDialog(context, "Error deleting Bus", dataResponse.message);
      }
    });
  }

}


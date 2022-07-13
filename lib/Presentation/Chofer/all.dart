import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/Business/ChoferBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/Chofer.dart';
import 'package:aplicacion_chofer_sig/Presentation/Layouts/header.dart';
import 'package:aplicacion_chofer_sig/Presentation/Chofer/edit.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/dialog.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';
import 'package:aplicacion_chofer_sig/route_generator.dart';

import 'package:aplicacion_chofer_sig/env.dart';

class AllChofer extends StatefulWidget {
  const AllChofer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __AllChoferState();
  }
}

class __AllChoferState extends State<AllChofer> {
  ChoferBusiness choferBusiness = new ChoferBusiness();
  List<Widget> listaDeCards = List.generate(
      0,
      (index) => SizedBox(
            height: 1,
          ));

  @override
  void initState() {
    super.initState();
    loadChofer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style().backgroundColor(),
      appBar: headerAppBar(context),
      drawer: SideNav(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, choferCreateRoute());
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.black),
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
    return SafeArea(
        child: Container(
      padding: EdgeInsets.all(20.0),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          //searchBar(context),
          listOfChofer()
        ],
      ),
    ));
  }

  void loadChofer(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 10));
    showLoadingIndicator(context, '');
    DataResponse dataResponse = await choferBusiness.index();
    List<Chofer> items = dataResponse.data;
    setState(() {
      hideOpenDialog(context);
      items.forEach((item) {
        var c = cardChofer(context, item);
        listaDeCards.add(c);
      });
    });
  }

  Widget listOfChofer() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listaDeCards.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index) {
          return listaDeCards[index];
        });
  }

  Widget cardChofer(BuildContext context, Chofer chofer) {
    return Card(
      child: Container(
        height: 750,
        color: Style().backgroundColor(),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        child: SingleChildScrollView(
                            child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Carnet de Identidad : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                              Text(chofer.ci),

                              Text(
                                'Fecha de Nacimiento : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                              Text(chofer.fecha_nacimiento),

                              Text(
                                'Sexo : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                              if(chofer.sexo.toString() == '0')
                              Text('Masculino'),
                              if(chofer.sexo.toString() == '1')
                              Text('Femenino'),

                              Text(
                                'Telefono : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                              Text(chofer.telefono),

                              Text(
                                'Categoria de Licencia : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                              Text(chofer.categoria_licencia),

                              Text(
                                'Foto  : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                              Image.network(
                                host + '/storage/' + chofer.foto,
                                height: 100,
                                width:  100,
                              ),

                              Text(
                                'user_id  : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                              Text(chofer.user_id),
                              
                            ],
                          ),
                        )),
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
                              Navigator.pushNamed(context, choferEditRoute(),
                                  arguments: EditChoferArguments(chofer));
                            },
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          IconButton(
                            color: Style().primaryColor(),
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              showAlertDialogOptions(
                                  context, "Delete Chofer", "¿Are you sure?",
                                  () async {
                                await deleteChofer(chofer);
                              });
                            },
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
    );
  }

  Future<void> deleteChofer(Chofer chofer) async {
    showLoadingIndicator(context, 'Deleting Chofer...');
    DataResponse dataResponse = await choferBusiness.delete(chofer.id);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status) {
        Navigator.pushReplacementNamed(context, choferAllRoute());
      } else {
        showAlertDialog(context, "Error deleting Chofer", dataResponse.message);
      }
    });
  }
}

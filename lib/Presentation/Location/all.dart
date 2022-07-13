import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/Business/LocationBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/Location.dart';
import 'package:aplicacion_chofer_sig/Presentation/Layouts/header.dart';
import 'package:aplicacion_chofer_sig/Presentation/Location/edit.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/dialog.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';
import 'package:aplicacion_chofer_sig/route_generator.dart';
import 'package:aplicacion_chofer_sig/env.dart';

class AllLocation extends StatefulWidget{
  const AllLocation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __AllLocationState();
  }

}

class __AllLocationState extends State<AllLocation>{

  LocationBusiness locationBusiness=new LocationBusiness();
  List<Widget> listaDeCards=List.generate(0, (index) =>SizedBox(height: 1,));

  @override
  void initState() {
    super.initState();
    loadLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Style().backgroundColor(),
      appBar: headerAppBar(context),
      drawer: SideNav(),
      floatingActionButton:  FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context,locationCreateRoute());
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
                listOfLocation()
              ],
            ),
          )
      );

  }

  void loadLocation(BuildContext context) async{

    await Future.delayed(Duration(milliseconds: 10));
    showLoadingIndicator(context,'');
    DataResponse dataResponse=await locationBusiness.index();
    List<Location> items=dataResponse.data;
    setState(() {
      hideOpenDialog(context);
      items.forEach((item) {
        var c = cardLocation(context,item);
        listaDeCards.add(c);
      });
    });
  }

  Widget listOfLocation() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listaDeCards.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index) {
          return listaDeCards[index];
        });
  }

Widget cardLocation(BuildContext context,Location location){
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
                                  Text(location.lat),
                                  Text(location.long),
                                  Text(location.bus_id),
                                  Text(location.bus_route_id),

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
                              Navigator.pushNamed(context, locationEditRoute(),arguments: EditLocationArguments(location));
                            },
                          ),
                          SizedBox(width: 8,),
                          IconButton(
                            color: Style().primaryColor(),
                            icon: const Icon(Icons.delete),
                            onPressed: () async{
                              showAlertDialogOptions(context,"Delete Location","¿Are you sure?",
                                      () async{
                                await deleteLocation(location);
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

  Future<void> deleteLocation(Location location) async{
    showLoadingIndicator(context,'Deleting Location...');
    DataResponse dataResponse=await locationBusiness.delete(location.id);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context, locationAllRoute());
      }else{
        showAlertDialog(context, "Error deleting Location", dataResponse.message);
      }
    });
  }

}


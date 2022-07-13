import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/Business/PhotoBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/Photo.dart';
import 'package:aplicacion_chofer_sig/Presentation/Layouts/header.dart';
import 'package:aplicacion_chofer_sig/Presentation/Photo/edit.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/dialog.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';
import 'package:aplicacion_chofer_sig/route_generator.dart';

import 'package:aplicacion_chofer_sig/env.dart';

class AllPhoto extends StatefulWidget{
  const AllPhoto({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __AllPhotoState();
  }

}

class __AllPhotoState extends State<AllPhoto>{

  PhotoBusiness photoBusiness=new PhotoBusiness();
  List<Widget> listaDeCards=List.generate(0, (index) =>SizedBox(height: 1,));

  @override
  void initState() {
    super.initState();
    loadPhoto(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Style().backgroundColor(),
      appBar: headerAppBar(context),
      drawer: SideNav(),
      floatingActionButton:  FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context,photoCreateRoute());
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
                listOfPhoto()
              ],
            ),
          )
      );

  }

  void loadPhoto(BuildContext context) async{

    await Future.delayed(Duration(milliseconds: 10));
    showLoadingIndicator(context,'');
    DataResponse dataResponse=await photoBusiness.index();
    List<Photo> items=dataResponse.data;
    setState(() {
      hideOpenDialog(context);
      items.forEach((item) {
        var c = cardPhoto(context,item);
        listaDeCards.add(c);
      });
    });
  }

  Widget listOfPhoto() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listaDeCards.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index) {
          return listaDeCards[index];
        });
  }

Widget cardPhoto(BuildContext context,Photo photo){
    return Card(
      child:Container(
        height: 400,
        // width:  200,
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
                                'Imagen del Bus : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),
                                  Image.network(host+'/storage/'+photo.image,height: 50,),

                                  Text(
                                'Ruta : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18,
                                ),
                              ),

                                  if(photo.bus_id.toString() == '1')
                                  Text('Linea 1'),
                                  if(photo.bus_id.toString() == '2')
                                  Text('Linea 2'),
                                  if(photo.bus_id.toString() == '3')
                                  Text('Linea 5'),
                                  if(photo.bus_id.toString() == '4')
                                  Text('Linea 8'),
                                  if(photo.bus_id.toString() == '5')
                                  Text('Linea 9'),
                                  if(photo.bus_id.toString() == '6')
                                  Text('Linea 10'),
                                  if(photo.bus_id.toString() == '7')
                                  Text('Linea 11'),
                                  if(photo.bus_id.toString() == '8')
                                  Text('Linea 16'),
                                  if(photo.bus_id.toString() == '9')
                                  Text('Linea 17'),
                                  if(photo.bus_id.toString() == '10')
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
                              Navigator.pushNamed(context, photoEditRoute(),arguments: EditPhotoArguments(photo));
                            },
                          ),
                          SizedBox(width: 8,),
                          IconButton(
                            color: Style().primaryColor(),
                            icon: const Icon(Icons.delete),
                            onPressed: () async{
                              showAlertDialogOptions(context,"Delete Photo","¿Are you sure?",
                                      () async{
                                await deletePhoto(photo);
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

  Future<void> deletePhoto(Photo photo) async{
    showLoadingIndicator(context,'Deleting Photo...');
    DataResponse dataResponse=await photoBusiness.delete(photo.id);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context, photoAllRoute());
      }else{
        showAlertDialog(context, "Error deleting Photo", dataResponse.message);
      }
    });
  }

}


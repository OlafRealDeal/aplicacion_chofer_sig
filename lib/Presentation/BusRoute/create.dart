import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplicacion_chofer_sig/Business/BusRouteBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/BusRoute.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/buttons.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/dialog.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';

import 'package:aplicacion_chofer_sig/route_generator.dart';

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/foundation.dart';

import 'package:aplicacion_chofer_sig/assets/widgets/forms.dart';



class CreateBusRoute extends StatefulWidget{
  const CreateBusRoute({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return __CreateBusRouteState();
  }

}

class __CreateBusRouteState extends State<CreateBusRoute>{

  final _formKey = GlobalKey<FormState>();
  bool isInitState=true;
  BusRouteBusiness busrouteBusiness=new BusRouteBusiness();


  final controllerline = TextEditingController();

  String line = '';


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    if (isInitState){
      isInitState=false;
      controllerline.addListener(() {
        line = controllerline.text;
      });

    }
    
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
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
      )
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
                cardBusRoute(context),
                SizedBox(height: 10,),
                buttonSeccondary(context, "Guardar", storeBusRoute),
                SizedBox(height: 10,),
                buttonPrimary(context, "Cancelar", cancel),
              ],
            ),
          )
      );
  }

  Widget cardBusRoute(BuildContext context){
    return Card(
      color: Style().backgroundColor(),
      child:Container(
        height: 100,
        color: Style().backgroundColor(),
        child: Column(
          children: [
            SizedBox(height: 5,),
            Center(
              child: Text('line', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
            //keyboardType: TextInputType.multiline,
            //minLines: 4,
            //maxLines: 4,
              controller: controllerline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
 
          ],
        ),
        margin: EdgeInsets.all(10),
      ),
      elevation: 8,
      margin: EdgeInsets.all(5),
    );
  }

  Future<void> storeBusRoute() async{
    if (_formKey.currentState!.validate()) {
      showLoadingIndicator(context,'Creating BusRoute...');

      DataResponse dataResponse=await busrouteBusiness.store(line);

      setState(() {
        hideOpenDialog(context);
        if (dataResponse.status){
          Navigator.pushReplacementNamed(context,busrouteAllRoute());
        }else{
          showAlertDialog(context, "Error to storage BusRoute", dataResponse.message);
        }
      });
    }
  }

  Future<void> cancel() async{
    Navigator.of(context).pop();
  }



  
}
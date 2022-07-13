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



class EditBusRouteArguments {
  final BusRoute busroute;

  EditBusRouteArguments(this.busroute);
}

class EditBusRoute extends StatefulWidget{
  const EditBusRoute({Key? key, }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __EditBusRouteState();
  }

}

class __EditBusRouteState extends State<EditBusRoute>{

  final _formKey = GlobalKey<FormState>();
  bool isInitState=true;
  BusRouteBusiness busrouteBusiness=new BusRouteBusiness();


  final controllerline = TextEditingController();


  BusRoute busroute=new BusRoute();


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    if (isInitState){
      isInitState=false;
      final args = ModalRoute.of(context)!.settings.arguments as EditBusRouteArguments;
      this.busroute=args.busroute;

      controllerline.text=args.busroute.line;
      controllerline.addListener(() {
        busroute.line = controllerline.text;
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
                buttonSeccondary(context, "Save", update),
                SizedBox(height: 10,),
                buttonPrimary(context, "Back", cancel)
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

  

  Future<void> update() async{
    if (_formKey.currentState!.validate()) {
      showLoadingIndicator(context,'Updating BusRoute...');

      DataResponse dataResponse=await busrouteBusiness.update(this.busroute);

      setState(() {
        hideOpenDialog(context);
        if (dataResponse.status){
          Navigator.pushReplacementNamed(context,busrouteAllRoute());
        }else{
          showAlertDialog(context, "Error updating BusRoute", dataResponse.message);
        }
      });
    }
  }

  Future<void> cancel() async{
    Navigator.of(context).pop();
  }



}
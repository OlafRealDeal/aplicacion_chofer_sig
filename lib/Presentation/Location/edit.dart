import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplicacion_chofer_sig/Business/LocationBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/Location.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/buttons.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/dialog.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';

import 'package:aplicacion_chofer_sig/route_generator.dart';

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/foundation.dart';

import 'package:aplicacion_chofer_sig/assets/widgets/forms.dart';

import 'package:aplicacion_chofer_sig/Business/BusBusiness.dart';
import 'package:aplicacion_chofer_sig/Entities/Bus.dart';
import 'package:aplicacion_chofer_sig/Business/BusRouteBusiness.dart';
import 'package:aplicacion_chofer_sig/Entities/BusRoute.dart';


class EditLocationArguments {
  final Location location;

  EditLocationArguments(this.location);
}

class EditLocation extends StatefulWidget{
  const EditLocation({Key? key, }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __EditLocationState();
  }

}

class __EditLocationState extends State<EditLocation>{

  final _formKey = GlobalKey<FormState>();
  bool isInitState=true;
  LocationBusiness locationBusiness=new LocationBusiness();
  BusBusiness busBusiness=new BusBusiness();
  BusRouteBusiness busrouteBusiness=new BusRouteBusiness();


  final controllerlat = TextEditingController();
  final controllerlong = TextEditingController();

    List<String> bus_idList = [];
    Map bus_idMap = { };
    List<String> bus_route_idList = [];
    Map bus_route_idMap = { };

  Location location=new Location();


  @override
  void initState() {
    super.initState();
    loadbus_idList();
    loadbus_route_idList();

  }

  void loadbus_idList() async{
    DataResponse data=await busBusiness.index();
    List<Bus> list=data.data;
    List<String> listStr=[];
    list.forEach((element) {
      listStr.add(element.id);
      bus_idMap[element.id]=element.id;
    });
    setState(() {
      bus_idList=listStr;
    });
  }

  void loadbus_route_idList() async{
    DataResponse data=await busrouteBusiness.index();
    List<BusRoute> list=data.data;
    List<String> listStr=[];
    list.forEach((element) {
      listStr.add(element.id);
      bus_route_idMap[element.id]=element.id;
    });
    setState(() {
      bus_route_idList=listStr;
    });
  }


  @override
  Widget build(BuildContext context) {

    if (isInitState){
      isInitState=false;
      final args = ModalRoute.of(context)!.settings.arguments as EditLocationArguments;
      this.location=args.location;

      controllerlat.text=args.location.lat;
      controllerlat.addListener(() {
        location.lat = controllerlat.text;
      });
      controllerlong.text=args.location.long;
      controllerlong.addListener(() {
        location.long = controllerlong.text;
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
                cardLocation(context),
                SizedBox(height: 10,),
                buttonSeccondary(context, "Save", update),
                SizedBox(height: 10,),
                buttonPrimary(context, "Back", cancel)
              ],
            ),
          )
      );
  }

  Widget cardLocation(BuildContext context){
    return Card(
      color: Style().backgroundColor(),
      child:Container(
        height: 400,
        color: Style().backgroundColor(),
        child: Column(
          children: [
            SizedBox(height: 5,),
            Center(
              child: Text('lat', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              controller: controllerlat,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('long', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              controller: controllerlong,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('bus_id', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            idDropdown(context,location.bus_id,bus_idList,bus_idMap,bus_idState),
            SizedBox(height: 5,),
            Center(
              child: Text('bus_route_id', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            idDropdown(context,location.bus_route_id,bus_route_idList,bus_route_idMap,bus_route_idState),
 
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
      showLoadingIndicator(context,'Updating Location...');

      DataResponse dataResponse=await locationBusiness.update(this.location);

      setState(() {
        hideOpenDialog(context);
        if (dataResponse.status){
          Navigator.pushReplacementNamed(context,locationAllRoute());
        }else{
          showAlertDialog(context, "Error updating Location", dataResponse.message);
        }
      });
    }
  }

  Future<void> cancel() async{
    Navigator.of(context).pop();
  }

  void bus_idState(String? id){
    setState(() {
      location.bus_id=id!;
    });
  }

  void bus_route_idState(String? id){
    setState(() {
      location.bus_route_id=id!;
    });
  }



}
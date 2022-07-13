import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplicacion_chofer_sig/Business/BusBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/Bus.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/buttons.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/dialog.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';

import 'package:aplicacion_chofer_sig/route_generator.dart';

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/foundation.dart';

import 'package:aplicacion_chofer_sig/assets/widgets/forms.dart';

import 'package:aplicacion_chofer_sig/Business/UserBusiness.dart';
import 'package:aplicacion_chofer_sig/Entities/User.dart';
import 'package:aplicacion_chofer_sig/Business/BusRouteBusiness.dart';
import 'package:aplicacion_chofer_sig/Entities/BusRoute.dart';


class CreateBus extends StatefulWidget{
  const CreateBus({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return __CreateBusState();
  }

}

class __CreateBusState extends State<CreateBus>{

  final _formKey = GlobalKey<FormState>();
  bool isInitState=true;
  BusBusiness busBusiness=new BusBusiness();
  UserBusiness userBusiness=new UserBusiness();
  BusRouteBusiness busrouteBusiness=new BusRouteBusiness();


  final controllerplaca = TextEditingController();
  final controllermodelo = TextEditingController();
  final controllercantidad_asientos = TextEditingController();
  final controllerfecha_asignacion = TextEditingController();
  final controllerfecha_baja = TextEditingController();
  final controllernumero_interno = TextEditingController();

  String placa = '';
  String modelo = '';
  String cantidad_asientos = '';
  String fecha_asignacion = '';
  String fecha_baja = '';
  String numero_interno = '';
  String esta_en_recorrido = '0';
  List<String> user_idList = [];
  Map user_idMap = { };
  String user_id = '';
  List<String> bus_route_idList = [];
  Map bus_route_idMap = { };
  String bus_route_id = '';


  @override
  void initState() {
    super.initState();
    loaduser_idList();
    loadbus_route_idList();

  }

  void loaduser_idList() async{
    DataResponse data=await userBusiness.index();
    List<User> list=data.data;
    List<String> listStr=[];
    list.forEach((element) {
      listStr.add(element.id);
      user_idMap[element.id]=element.id;
    });
    setState(() {
      if (!listStr.isEmpty){
        user_id=listStr[0];
      }
      user_idList=listStr;
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
      if (!listStr.isEmpty){
        bus_route_id=listStr[0];
      }
      bus_route_idList=listStr;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (isInitState){
      isInitState=false;
      controllerplaca.addListener(() {
        placa = controllerplaca.text;
      });
      controllermodelo.addListener(() {
        modelo = controllermodelo.text;
      });
      controllercantidad_asientos.addListener(() {
        cantidad_asientos = controllercantidad_asientos.text;
      });
      controllerfecha_asignacion.addListener(() {
        fecha_asignacion = controllerfecha_asignacion.text;
      });
      controllerfecha_baja.addListener(() {
        fecha_baja = controllerfecha_baja.text;
      });
      controllernumero_interno.addListener(() {
        numero_interno = controllernumero_interno.text;
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
                cardBus(context),
                SizedBox(height: 10,),
                buttonSeccondary(context, "Guardar", storeBus),
                SizedBox(height: 10,),
                buttonPrimary(context, "Cancelar", cancel),
              ],
            ),
          )
      );
  }

  Widget cardBus(BuildContext context){
    return Card(
      color: Style().backgroundColor(),
      child:Container(
        height: 900,
        color: Style().backgroundColor(),
        child: Column(
          children: [
            SizedBox(height: 5,),
            Center(
              child: Text('placa', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
            //keyboardType: TextInputType.multiline,
            //minLines: 4,
            //maxLines: 4,
              controller: controllerplaca,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('modelo', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
            //keyboardType: TextInputType.multiline,
            //minLines: 4,
            //maxLines: 4,
              controller: controllermodelo,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('cantidad_asientos', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: controllercantidad_asientos,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('fecha_asignacion', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
              keyboardType: TextInputType.datetime,
              readOnly: true,
              controller: controllerfecha_asignacion,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
              onTap: () async{ controllerfecha_asignacion.text=await getDate(context); },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('fecha_baja', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
              keyboardType: TextInputType.datetime,
              readOnly: true,
              controller: controllerfecha_baja,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
              onTap: () async{ controllerfecha_baja.text=await getDate(context); },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('numero_interno', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: controllernumero_interno,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('esta_en_recorrido', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            Checkbox(onChanged: (c){
              setState(() {
                esta_en_recorrido=(!(esta_en_recorrido=='1'))? '1':'0';
              });
            },value: esta_en_recorrido=='1'),
            SizedBox(height: 5,),
            Center(
              child: Text('user_id', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            idDropdown(context,user_id,user_idList,user_idMap,user_idState),
            SizedBox(height: 5,),
            Center(
              child: Text('bus_route_id', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            idDropdown(context,bus_route_id,bus_route_idList,bus_route_idMap,bus_route_idState),
 
          ],
        ),
        margin: EdgeInsets.all(10),
      ),
      elevation: 8,
      margin: EdgeInsets.all(5),
    );
  }

  Future<void> storeBus() async{
    if (_formKey.currentState!.validate()) {
      showLoadingIndicator(context,'Creating Bus...');

      DataResponse dataResponse=await busBusiness.store(placa,modelo,cantidad_asientos,fecha_asignacion,fecha_baja,numero_interno,esta_en_recorrido,user_id,bus_route_id);

      setState(() {
        hideOpenDialog(context);
        if (dataResponse.status){
          Navigator.pushReplacementNamed(context,busAllRoute());
        }else{
          showAlertDialog(context, "Error to storage Bus", dataResponse.message);
        }
      });
    }
  }

  Future<void> cancel() async{
    Navigator.of(context).pop();
  }

  void user_idState(String? id){
    setState(() {
      user_id=id!;
    });
  }

  void bus_route_idState(String? id){
    setState(() {
      bus_route_id=id!;
    });
  }



  
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplicacion_chofer_sig/Business/ChoferBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/Chofer.dart';
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


class CreateChofer extends StatefulWidget{
  const CreateChofer({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return __CreateChoferState();
  }

}

class __CreateChoferState extends State<CreateChofer>{

  final _formKey = GlobalKey<FormState>();
  bool isInitState=true;
  ChoferBusiness choferBusiness=new ChoferBusiness();
  UserBusiness userBusiness=new UserBusiness();


  final controllerci = TextEditingController();
  final controllerfecha_nacimiento = TextEditingController();
  final controllertelefono = TextEditingController();
  final controllercategoria_licencia = TextEditingController();

  String ci = '';
  String fecha_nacimiento = '';
  String sexo = '0';
  String telefono = '';
  String categoria_licencia = '';
  dynamic foto;
  List<String> user_idList = [];
  Map user_idMap = { };
  String user_id = '';


  @override
  void initState() {
    super.initState();
    loaduser_idList();

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


  @override
  Widget build(BuildContext context) {
    if (isInitState){
      isInitState=false;
      controllerci.addListener(() {
        ci = controllerci.text;
      });
      controllerfecha_nacimiento.addListener(() {
        fecha_nacimiento = controllerfecha_nacimiento.text;
      });
      controllertelefono.addListener(() {
        telefono = controllertelefono.text;
      });
      controllercategoria_licencia.addListener(() {
        categoria_licencia = controllercategoria_licencia.text;
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
                cardChofer(context),
                SizedBox(height: 10,),
                buttonSeccondary(context, "Guardar", storeChofer),
                SizedBox(height: 10,),
                buttonPrimary(context, "Cancelar", cancel),
              ],
            ),
          )
      );
  }

  Widget cardChofer(BuildContext context){
    return Card(
      color: Style().backgroundColor(),
      child:Container(
        height: 700,
        color: Style().backgroundColor(),
        child: Column(
          children: [
            SizedBox(height: 5,),
            Center(
              child: Text('ci', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
            //keyboardType: TextInputType.multiline,
            //minLines: 4,
            //maxLines: 4,
              controller: controllerci,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('fecha_nacimiento', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
              keyboardType: TextInputType.datetime,
              readOnly: true,
              controller: controllerfecha_nacimiento,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
              onTap: () async{ controllerfecha_nacimiento.text=await getDate(context); },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('sexo', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            Checkbox(onChanged: (c){
              setState(() {
                sexo=(!(sexo=='1'))? '1':'0';
              });
            },value: sexo=='1'),
            SizedBox(height: 5,),
            Center(
              child: Text('telefono', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: controllertelefono,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('categoria_licencia', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
            //keyboardType: TextInputType.multiline,
            //minLines: 4,
            //maxLines: 4,
              controller: controllercategoria_licencia,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
            SizedBox(height: 20,),
            buttonPrimary(context, 'foto',()async{ foto= await uploadImage(); } ),
            SizedBox(height: 20,),
            SizedBox(height: 5,),
            Center(
              child: Text('user_id', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            idDropdown(context,user_id,user_idList,user_idMap,user_idState),
 
          ],
        ),
        margin: EdgeInsets.all(10),
      ),
      elevation: 8,
      margin: EdgeInsets.all(5),
    );
  }

  Future<void> storeChofer() async{
    if (_formKey.currentState!.validate()) {
      showLoadingIndicator(context,'Creating Chofer...');

      DataResponse dataResponse=await choferBusiness.store(ci,fecha_nacimiento,sexo,telefono,categoria_licencia,foto,user_id);

      setState(() {
        hideOpenDialog(context);
        if (dataResponse.status){
          Navigator.pushReplacementNamed(context,choferAllRoute());
        }else{
          showAlertDialog(context, "Error to storage Chofer", dataResponse.message);
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



  
}
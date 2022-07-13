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


class EditChoferArguments {
  final Chofer chofer;

  EditChoferArguments(this.chofer);
}

class EditChofer extends StatefulWidget{
  const EditChofer({Key? key, }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __EditChoferState();
  }

}

class __EditChoferState extends State<EditChofer>{

  final _formKey = GlobalKey<FormState>();
  bool isInitState=true;
  ChoferBusiness choferBusiness=new ChoferBusiness();
  UserBusiness userBusiness=new UserBusiness();


  final controllerci = TextEditingController();
  final controllerfecha_nacimiento = TextEditingController();
  final controllertelefono = TextEditingController();
  final controllercategoria_licencia = TextEditingController();

    List<String> user_idList = [];
    Map user_idMap = { };

  Chofer chofer=new Chofer();


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
      user_idList=listStr;
    });
  }


  @override
  Widget build(BuildContext context) {

    if (isInitState){
      isInitState=false;
      final args = ModalRoute.of(context)!.settings.arguments as EditChoferArguments;
      this.chofer=args.chofer;

      controllerci.text=args.chofer.ci;
      controllerci.addListener(() {
        chofer.ci = controllerci.text;
      });
      controllerfecha_nacimiento.text=args.chofer.fecha_nacimiento;
      controllerfecha_nacimiento.addListener(() {
        chofer.fecha_nacimiento = controllerfecha_nacimiento.text;
      });
      controllertelefono.text=args.chofer.telefono;
      controllertelefono.addListener(() {
        chofer.telefono = controllertelefono.text;
      });
      controllercategoria_licencia.text=args.chofer.categoria_licencia;
      controllercategoria_licencia.addListener(() {
        chofer.categoria_licencia = controllercategoria_licencia.text;
      });
      chofer.foto='';

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
                buttonSeccondary(context, "Save", update),
                SizedBox(height: 10,),
                buttonPrimary(context, "Back", cancel)
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
              child: Text('fecha de nacimiento', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
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
                chofer.sexo=(!(chofer.sexo=='1'))? '1':'0';
              });
            },value: chofer.sexo=='1'),
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
              child: Text('categoria de licencia', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
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
            buttonPrimary(context, 'foto',()async{ dynamic datafoto= await uploadImage(); if (datafoto!=null){ chofer.foto=datafoto; }  } ),
            SizedBox(height: 20,),
            SizedBox(height: 5,),
            Center(
              child: Text('user_id', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            idDropdown(context,chofer.user_id,user_idList,user_idMap,user_idState),
 
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
      showLoadingIndicator(context,'Updating Chofer...');

      DataResponse dataResponse=await choferBusiness.update(this.chofer);

      setState(() {
        hideOpenDialog(context);
        if (dataResponse.status){
          Navigator.pushReplacementNamed(context,choferAllRoute());
        }else{
          showAlertDialog(context, "Error updating Chofer", dataResponse.message);
        }
      });
    }
  }

  Future<void> cancel() async{
    Navigator.of(context).pop();
  }

  void user_idState(String? id){
    setState(() {
      chofer.user_id=id!;
    });
  }



}
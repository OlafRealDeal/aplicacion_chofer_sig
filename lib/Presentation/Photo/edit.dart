import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplicacion_chofer_sig/Business/PhotoBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/Photo.dart';
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


class EditPhotoArguments {
  final Photo photo;

  EditPhotoArguments(this.photo);
}

class EditPhoto extends StatefulWidget{
  const EditPhoto({Key? key, }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __EditPhotoState();
  }

}

class __EditPhotoState extends State<EditPhoto>{

  final _formKey = GlobalKey<FormState>();
  bool isInitState=true;
  PhotoBusiness photoBusiness=new PhotoBusiness();
  BusBusiness busBusiness=new BusBusiness();



    List<String> bus_idList = [];
    Map bus_idMap = { };

  Photo photo=new Photo();


  @override
  void initState() {
    super.initState();
    loadbus_idList();

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


  @override
  Widget build(BuildContext context) {

    if (isInitState){
      isInitState=false;
      final args = ModalRoute.of(context)!.settings.arguments as EditPhotoArguments;
      this.photo=args.photo;

      photo.image='';

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
                cardPhoto(context),
                SizedBox(height: 10,),
                buttonSeccondary(context, "Save", update),
                SizedBox(height: 10,),
                buttonPrimary(context, "Back", cancel)
              ],
            ),
          )
      );
  }

  Widget cardPhoto(BuildContext context){
    return Card(
      color: Style().backgroundColor(),
      child:Container(
        height: 200,
        color: Style().backgroundColor(),
        child: Column(
          children: [
            SizedBox(height: 20,),
            buttonPrimary(context, 'image',()async{ dynamic dataimage= await uploadImage(); if (dataimage!=null){ photo.image=dataimage; }  } ),
            SizedBox(height: 20,),
            SizedBox(height: 5,),
            Center(
              child: Text('bus_id', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            idDropdown(context,photo.bus_id,bus_idList,bus_idMap,bus_idState),
 
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
      showLoadingIndicator(context,'Updating Photo...');

      DataResponse dataResponse=await photoBusiness.update(this.photo);

      setState(() {
        hideOpenDialog(context);
        if (dataResponse.status){
          Navigator.pushReplacementNamed(context,photoAllRoute());
        }else{
          showAlertDialog(context, "Error updating Photo", dataResponse.message);
        }
      });
    }
  }

  Future<void> cancel() async{
    Navigator.of(context).pop();
  }

  void bus_idState(String? id){
    setState(() {
      photo.bus_id=id!;
    });
  }



}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplicacion_chofer_sig/Business/UserBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/User.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/buttons.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/dialog.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';
import 'package:aplicacion_chofer_sig/route_generator.dart';

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/foundation.dart';

import 'package:aplicacion_chofer_sig/assets/widgets/forms.dart';



class EditUserArguments {
  final User user;

  EditUserArguments(this.user);
}

class EditUser extends StatefulWidget{
  const EditUser({Key? key, }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __EditUserState();
  }

}

class __EditUserState extends State<EditUser>{

  final _formKey = GlobalKey<FormState>();
  bool isInitState=true;
  UserBusiness userBusiness=new UserBusiness();


  final controllername = TextEditingController();
  final controlleremail = TextEditingController();
  final controllerpassword = TextEditingController();


  User user=new User();


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    if (isInitState){
      isInitState=false;
      final args = ModalRoute.of(context)!.settings.arguments as EditUserArguments;
      this.user=args.user;

      controllername.text=args.user.name;
      controllername.addListener(() {
        user.name = controllername.text;
      });
      controlleremail.text=args.user.email;
      controlleremail.addListener(() {
        user.email = controlleremail.text;
      });
      controllerpassword.text=args.user.password;
      controllerpassword.addListener(() {
        user.password = controllerpassword.text;
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
                cardUser(context),
                SizedBox(height: 10,),
                buttonSeccondary(context, "Save", update),
                SizedBox(height: 10,),
                buttonPrimary(context, "Back", cancel)
              ],
            ),
          )
      );
  }

  Widget cardUser(BuildContext context){
    return Card(
      color: Style().backgroundColor(),
      child:Container(
        height: 300,
        color: Style().backgroundColor(),
        child: Column(
          children: [
            SizedBox(height: 5,),
            Center(
              child: Text('name', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
            //keyboardType: TextInputType.multiline,
            //minLines: 4,
            //maxLines: 4,
              controller: controllername,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('email', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
            //keyboardType: TextInputType.multiline,
            //minLines: 4,
            //maxLines: 4,
              controller: controlleremail,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El campo no puede estar vacio.';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('password', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextFormField(
            //keyboardType: TextInputType.multiline,
            //minLines: 4,
            //maxLines: 4,
              controller: controllerpassword,
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
      showLoadingIndicator(context,'Updating User...');

      DataResponse dataResponse=await userBusiness.update(this.user);

      setState(() {
        hideOpenDialog(context);
        if (dataResponse.status){
          Navigator.pushReplacementNamed(context,userAllRoute());
        }else{
          showAlertDialog(context, "Error updating User", dataResponse.message);
        }
      });
    }
  }

  Future<void> cancel() async{
    Navigator.of(context).pop();
  }



}
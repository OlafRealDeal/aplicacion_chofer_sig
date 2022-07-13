import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';

Widget searchBar(BuildContext context,Function(BuildContext,String) action){
  return Column(
    children: [
      CupertinoSearchTextField(
        backgroundColor: Style().backgroundColor(),
        onSubmitted: (String text){

        } ,
        onChanged: (String text){
          action(context,text);
        },
      ),
      Divider(
        color: Colors.green.shade300,
      ),
    ],
  );
}
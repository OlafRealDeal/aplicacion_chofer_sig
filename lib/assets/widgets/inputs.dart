import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';

// ignore: must_be_immutable
class CustomInputField extends StatelessWidget {
  Icon fieldIcon;
  String hinText;
  var controller;
  bool obscure;

  CustomInputField(this.fieldIcon, this.hinText, this.controller, this.obscure);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.all(
            Radius.circular(20.0)),
        color: Style().textColorPrimary(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: fieldIcon,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              width: 250,
              height: 60,
              child: Padding(

                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: obscure,
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hinText,
                      fillColor: Colors.white,
                      filled: true),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/env.dart';

class Style{

  Color textColorPrimary(){
    Color color=Colors.black;
    switch(style) {
      case '1': {
        color=Colors.black;
      }
      break;
    }
    return color;
  }

  Color textColorSeccondary(){
    Color color=Colors.white;
    switch(style) {
      case '1': {
        color=Colors.white;
      }
      break;
    }
    return color;
  }

  Color backgroundColor(){
    Color color=Colors.white;
    switch(style) {
      case '1': {
        color=Colors.white;
      }
      break;
    }
    return color;
  }

  Color primaryColor(){
    Color color=Colors.black54;
    switch(style) {
      case '1': {
        color=Colors.black54;
      }
      break;
    }
    return color;
  }

  Color seccondaryColor(){
    Color color=Colors.black12;
    switch(style) {
      case '1': {
        color=Colors.black12;
      }
      break;
    }
    return color;
  }

  Color uiColor(){
    Color color=Colors.red;
    switch(style) {
      case '1': {
        color=Colors.red;
      }
      break;
    }
    return color;
  }

}


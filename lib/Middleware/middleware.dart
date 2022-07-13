import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/Presentation/User/login.dart';
import 'package:aplicacion_chofer_sig/Presentation/menu.dart';
import 'package:aplicacion_chofer_sig/Session/UserSession.dart';
import 'package:aplicacion_chofer_sig/route_generator.dart';

bool auth(){
  return UserSession.user.token!='';
}

bool guest(){
  return UserSession.user.token=='';
}

Future<void> loadMiddleware()async{
  await UserSession.getSession();
}

Route middleware({required List<String> guards, required Widget builder, required RouteSettings settings}) {

  bool authenticated=true;
  String stopIn='';

  guards.forEach((guard) {
    if (authenticated){
      stopIn=guard;
      //AUTH
      if (guard=='auth'){
        authenticated=auth();
      }
      //GUEST
      if (guard=='guest'){
        authenticated=guest();
      }
      //OTHER
    }

  });


  //REDIRECT IF AUTHENTICATED
  if (stopIn=='guest' && !authenticated){
    RouteSettings routeSettings=RouteSettings(name: menuRoute(),arguments: settings.arguments);
    return MaterialPageRoute(settings: routeSettings, builder: (context) => const Menu());
    //return const Menu();
  }

  //AUTHENTICATE
  if (stopIn=='auth' && !authenticated){
    RouteSettings routeSettings=RouteSettings(name: loginRoute(),arguments: settings.arguments);
    return MaterialPageRoute(settings: routeSettings, builder: (context) => const Login());
  }
  //CONTINUE
  return MaterialPageRoute(settings: settings, builder: (context) => builder);
}
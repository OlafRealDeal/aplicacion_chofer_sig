import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/Presentation/404.dart';
import 'package:aplicacion_chofer_sig/Presentation/User/login.dart';
import 'Presentation/User/signup.dart';
import 'package:aplicacion_chofer_sig/Middleware/middleware.dart';

import 'package:aplicacion_chofer_sig/Presentation/menu.dart';
import 'package:aplicacion_chofer_sig/Presentation/User/all.dart' as UserAll;
import 'package:aplicacion_chofer_sig/Presentation/User/create.dart' as UserCreate;
import 'package:aplicacion_chofer_sig/Presentation/User/edit.dart' as UserEdit;
import 'package:aplicacion_chofer_sig/Presentation/Chofer/all.dart' as ChoferAll;
import 'package:aplicacion_chofer_sig/Presentation/Chofer/create.dart' as ChoferCreate;
import 'package:aplicacion_chofer_sig/Presentation/Chofer/edit.dart' as ChoferEdit;
import 'package:aplicacion_chofer_sig/Presentation/BusRoute/all.dart' as BusRouteAll;
import 'package:aplicacion_chofer_sig/Presentation/BusRoute/create.dart' as BusRouteCreate;
import 'package:aplicacion_chofer_sig/Presentation/BusRoute/edit.dart' as BusRouteEdit;
import 'package:aplicacion_chofer_sig/Presentation/EntryPoint/all.dart' as EntryPointAll;
import 'package:aplicacion_chofer_sig/Presentation/EntryPoint/create.dart' as EntryPointCreate;
import 'package:aplicacion_chofer_sig/Presentation/EntryPoint/edit.dart' as EntryPointEdit;
import 'package:aplicacion_chofer_sig/Presentation/ExitPoint/all.dart' as ExitPointAll;
import 'package:aplicacion_chofer_sig/Presentation/ExitPoint/create.dart' as ExitPointCreate;
import 'package:aplicacion_chofer_sig/Presentation/ExitPoint/edit.dart' as ExitPointEdit;
import 'package:aplicacion_chofer_sig/Presentation/Bus/all.dart' as BusAll;
import 'package:aplicacion_chofer_sig/Presentation/Bus/create.dart' as BusCreate;
import 'package:aplicacion_chofer_sig/Presentation/Bus/edit.dart' as BusEdit;
import 'package:aplicacion_chofer_sig/Presentation/Photo/all.dart' as PhotoAll;
import 'package:aplicacion_chofer_sig/Presentation/Photo/create.dart' as PhotoCreate;
import 'package:aplicacion_chofer_sig/Presentation/Photo/edit.dart' as PhotoEdit;
import 'package:aplicacion_chofer_sig/Presentation/Location/all.dart' as LocationAll;
import 'package:aplicacion_chofer_sig/Presentation/Location/create.dart' as LocationCreate;
import 'package:aplicacion_chofer_sig/Presentation/Location/edit.dart' as LocationEdit;


class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args=settings.arguments;

    String name=settings.name?? "";
    var requests=request(name);

    if (requests.length>0){
      name=name.split("?")[0];
    }

    switch (name){
      case '/login':
        return middleware(guards: ['guest'], builder: const Login(), settings: settings);
      case '/signup':
        return middleware(guards: ['guest'], builder: const SignUp(), settings: settings);
      case '/menu':
        return middleware(guards: ['auth'], builder: const Menu(), settings: settings);
      case '/user/all':
        return middleware(guards: ['auth'], builder: const UserAll.AllUser(), settings: settings);
      case '/user/create':
        return middleware(guards: ['auth'], builder: const UserCreate.CreateUser(), settings: settings);
      case '/user/edit':
        if (args==null){
          return middleware(guards: ['auth'], builder: const UserAll.AllUser(), settings: settings);
       }
       return middleware(guards: ['auth'], builder: const UserEdit.EditUser(), settings: settings);
      case '/chofer/all':
        return middleware(guards: ['auth'], builder: const ChoferAll.AllChofer(), settings: settings);
      case '/chofer/create':
        return middleware(guards: ['auth'], builder: const ChoferCreate.CreateChofer(), settings: settings);
      case '/chofer/edit':
        if (args==null){
          return middleware(guards: ['auth'], builder: const ChoferAll.AllChofer(), settings: settings);
       }
       return middleware(guards: ['auth'], builder: const ChoferEdit.EditChofer(), settings: settings);
      case '/busroute/all':
        return middleware(guards: ['auth'], builder: const BusRouteAll.AllBusRoute(), settings: settings);
      case '/busroute/create':
        return middleware(guards: ['auth'], builder: const BusRouteCreate.CreateBusRoute(), settings: settings);
      case '/busroute/edit':
        if (args==null){
          return middleware(guards: ['auth'], builder: const BusRouteAll.AllBusRoute(), settings: settings);
       }
       return middleware(guards: ['auth'], builder: const BusRouteEdit.EditBusRoute(), settings: settings);
      case '/entrypoint/all':
        return middleware(guards: ['auth'], builder: const EntryPointAll.AllEntryPoint(), settings: settings);
      case '/entrypoint/create':
        return middleware(guards: ['auth'], builder: const EntryPointCreate.CreateEntryPoint(), settings: settings);
      case '/entrypoint/edit':
        if (args==null){
          return middleware(guards: ['auth'], builder: const EntryPointAll.AllEntryPoint(), settings: settings);
       }
       return middleware(guards: ['auth'], builder: const EntryPointEdit.EditEntryPoint(), settings: settings);
      case '/exitpoint/all':
        return middleware(guards: ['auth'], builder: const ExitPointAll.AllExitPoint(), settings: settings);
      case '/exitpoint/create':
        return middleware(guards: ['auth'], builder: const ExitPointCreate.CreateExitPoint(), settings: settings);
      case '/exitpoint/edit':
        if (args==null){
          return middleware(guards: ['auth'], builder: const ExitPointAll.AllExitPoint(), settings: settings);
       }
       return middleware(guards: ['auth'], builder: const ExitPointEdit.EditExitPoint(), settings: settings);
      case '/bus/all':
        return middleware(guards: ['auth'], builder: const BusAll.AllBus(), settings: settings);
      case '/bus/create':
        return middleware(guards: ['auth'], builder: const BusCreate.CreateBus(), settings: settings);
      case '/bus/edit':
        if (args==null){
          return middleware(guards: ['auth'], builder: const BusAll.AllBus(), settings: settings);
       }
       return middleware(guards: ['auth'], builder: const BusEdit.EditBus(), settings: settings);
      case '/photo/all':
        return middleware(guards: ['auth'], builder: const PhotoAll.AllPhoto(), settings: settings);
      case '/photo/create':
        return middleware(guards: ['auth'], builder: const PhotoCreate.CreatePhoto(), settings: settings);
      case '/photo/edit':
        if (args==null){
          return middleware(guards: ['auth'], builder: const PhotoAll.AllPhoto(), settings: settings);
       }
       return middleware(guards: ['auth'], builder: const PhotoEdit.EditPhoto(), settings: settings);
      case '/location/all':
        return middleware(guards: ['auth'], builder: const LocationAll.AllLocation(), settings: settings);
      case '/location/create':
        return middleware(guards: ['auth'], builder: const LocationCreate.CreateLocation(), settings: settings);
      case '/location/edit':
        if (args==null){
          return middleware(guards: ['auth'], builder: const LocationAll.AllLocation(), settings: settings);
       }
       return middleware(guards: ['auth'], builder: const LocationEdit.EditLocation(), settings: settings);

      default:
        return MaterialPageRoute(settings: settings, builder: (context) => const Error404());
    }
  }

  static Map<String,String> request(String name){

    Map<String,String> result={};
    if (name.split("?").length==2){
      List<String> queries=name.split("?")[1].split("&&");

      queries.forEach((element) {
        List map=element.split("=");
        if (map.length==2){
          result[map[0]]=map[1];
        }
      });
    }
    return result;
  }
}

String loginRoute() => '/login'; 
String signupRoute() => '/signup';
String menuRoute() => '/menu';
String userAllRoute() => '/user/all';
String userCreateRoute() => '/user/create';
String userEditRoute() => '/user/edit';
String choferAllRoute() => '/chofer/all';
String choferCreateRoute() => '/chofer/create';
String choferEditRoute() => '/chofer/edit';
String busrouteAllRoute() => '/busroute/all';
String busrouteCreateRoute() => '/busroute/create';
String busrouteEditRoute() => '/busroute/edit';
String entrypointAllRoute() => '/entrypoint/all';
String entrypointCreateRoute() => '/entrypoint/create';
String entrypointEditRoute() => '/entrypoint/edit';
String exitpointAllRoute() => '/exitpoint/all';
String exitpointCreateRoute() => '/exitpoint/create';
String exitpointEditRoute() => '/exitpoint/edit';
String busAllRoute() => '/bus/all';
String busCreateRoute() => '/bus/create';
String busEditRoute() => '/bus/edit';
String photoAllRoute() => '/photo/all';
String photoCreateRoute() => '/photo/create';
String photoEditRoute() => '/photo/edit';
String locationAllRoute() => '/location/all';
String locationCreateRoute() => '/location/create';
String locationEditRoute() => '/location/edit';



//        settings=RouteSettings(name: 'test');
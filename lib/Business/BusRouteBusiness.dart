import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Data/BusRouteData.dart';
import 'package:aplicacion_chofer_sig/Entities/BusRoute.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:aplicacion_chofer_sig/Session/UserSession.dart';


class BusRouteBusiness{
  BusRouteData busrouteData=new BusRouteData();


  Future<DataResponse> index() async{

    DataResponse dataResponse=await busrouteData.index(UserSession.user.token );
    return dataResponse;
  }

  Future<DataResponse> store(line) async{
    BusRoute busroute=new BusRoute();
    busroute.line=line;

    DataResponse dataResponse=await busrouteData.store(UserSession.user.token,busroute);
    return dataResponse;
  }

  Future<DataResponse> update(BusRoute busroute) async{
    DataResponse dataResponse=await busrouteData.update(UserSession.user.token,busroute);
    return dataResponse;
  }

  Future<DataResponse> delete(String id) async{
    return await busrouteData.delete(UserSession.user.token,id);
  }


}
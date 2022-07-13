import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Data/ExitPointData.dart';
import 'package:aplicacion_chofer_sig/Entities/ExitPoint.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:aplicacion_chofer_sig/Session/UserSession.dart';


class ExitPointBusiness{
  ExitPointData exitpointData=new ExitPointData();


  Future<DataResponse> index() async{
    String bus_route_id='';

    DataResponse dataResponse=await exitpointData.index(UserSession.user.token ,bus_route_id);
    return dataResponse;
  }

  Future<DataResponse> store(lat,long,bus_route_id) async{
    ExitPoint exitpoint=new ExitPoint();
    exitpoint.lat=lat;
    exitpoint.long=long;
    exitpoint.bus_route_id=bus_route_id;

    DataResponse dataResponse=await exitpointData.store(UserSession.user.token,exitpoint);
    return dataResponse;
  }

  Future<DataResponse> update(ExitPoint exitpoint) async{
    DataResponse dataResponse=await exitpointData.update(UserSession.user.token,exitpoint);
    return dataResponse;
  }

  Future<DataResponse> delete(String id) async{
    return await exitpointData.delete(UserSession.user.token,id);
  }


}
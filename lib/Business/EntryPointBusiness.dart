import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Data/EntryPointData.dart';
import 'package:aplicacion_chofer_sig/Entities/EntryPoint.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:aplicacion_chofer_sig/Session/UserSession.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class EntryPointBusiness{
  EntryPointData entrypointData=new EntryPointData();


  Future<DataResponse> index() async{
    String bus_route_id='';

    DataResponse dataResponse=await entrypointData.index(UserSession.user.token ,bus_route_id);
    return dataResponse;
  }

  Future<DataResponse> indexParam(String bus_route_id) async{
    DataResponse dataResponse=await entrypointData.index(UserSession.user.token ,bus_route_id);
    return dataResponse;
  }

  Future<DataResponse> indexParamLatLong(String bus_route_id) async{
    DataResponse dataResponse=await entrypointData.index(UserSession.user.token ,bus_route_id);
    List<LatLng> list=[];
    
    if (dataResponse.status){
      List<EntryPoint> items=dataResponse.data;
      items.forEach((element) { 
        LatLng val=new LatLng(double.parse(element.lat),double.parse(element.long));
        list.add(val);
      });
    }
    dataResponse.data=list;
    
    return dataResponse;
  }

  Future<DataResponse> store(lat,long,bus_route_id) async{
    EntryPoint entrypoint=new EntryPoint();
    entrypoint.lat=lat;
    entrypoint.long=long;
    entrypoint.bus_route_id=bus_route_id;

    DataResponse dataResponse=await entrypointData.store(UserSession.user.token,entrypoint);
    return dataResponse;
  }

  Future<DataResponse> update(EntryPoint entrypoint) async{
    DataResponse dataResponse=await entrypointData.update(UserSession.user.token,entrypoint);
    return dataResponse;
  }

  Future<DataResponse> delete(String id) async{
    return await entrypointData.delete(UserSession.user.token,id);
  }


}
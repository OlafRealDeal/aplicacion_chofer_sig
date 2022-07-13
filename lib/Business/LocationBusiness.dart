import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Data/LocationData.dart';
import 'package:aplicacion_chofer_sig/Entities/Location.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:aplicacion_chofer_sig/Session/UserSession.dart';


class LocationBusiness{
  LocationData locationData=new LocationData();


  Future<DataResponse> index() async{
    String bus_id='';
    String bus_route_id='';

    DataResponse dataResponse=await locationData.index(UserSession.user.token ,bus_id,bus_route_id);
    return dataResponse;
  }

  Future<DataResponse> store(lat,long,bus_id,bus_route_id) async{
    Location location=new Location();
    location.lat=lat;
    location.long=long;
    location.bus_id=bus_id;
    location.bus_route_id=bus_route_id;

    DataResponse dataResponse=await locationData.store(UserSession.user.token,location);
    return dataResponse;
  }

  Future<DataResponse> update(Location location) async{
    DataResponse dataResponse=await locationData.update(UserSession.user.token,location);
    return dataResponse;
  }

  Future<DataResponse> delete(String id) async{
    return await locationData.delete(UserSession.user.token,id);
  }


}
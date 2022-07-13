import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Data/BusData.dart';
import 'package:aplicacion_chofer_sig/Entities/Bus.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:aplicacion_chofer_sig/Session/UserSession.dart';


class BusBusiness{
  BusData busData=new BusData();


  Future<DataResponse> index() async{
    String user_id='';
    String bus_route_id='';

    DataResponse dataResponse=await busData.index(UserSession.user.token ,user_id,bus_route_id);
    return dataResponse;
  }

  Future<DataResponse> store(placa,modelo,cantidad_asientos,fecha_asignacion,fecha_baja,numero_interno,esta_en_recorrido,user_id,bus_route_id) async{
    Bus bus=new Bus();
    bus.placa=placa;
    bus.modelo=modelo;
    bus.cantidad_asientos=cantidad_asientos;
    bus.fecha_asignacion=fecha_asignacion;
    bus.fecha_baja=fecha_baja;
    bus.numero_interno=numero_interno;
    bus.esta_en_recorrido=esta_en_recorrido;
    bus.user_id=user_id;
    bus.bus_route_id=bus_route_id;

    DataResponse dataResponse=await busData.store(UserSession.user.token,bus);
    return dataResponse;
  }

  Future<DataResponse> update(Bus bus) async{
    DataResponse dataResponse=await busData.update(UserSession.user.token,bus);
    return dataResponse;
  }

  Future<DataResponse> delete(String id) async{
    return await busData.delete(UserSession.user.token,id);
  }


}
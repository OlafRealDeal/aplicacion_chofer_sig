import 'dart:convert';
import 'dart:io';

import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/Bus.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:flutter/foundation.dart';

class BusData{

  Future<DataResponse> index(String token ,user_id,bus_route_id) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/bus'+'?user_id='+user_id+'&&bus_route_id='+bus_route_id);
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      if (kDebugMode) {
        print(response.body);
      }
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<Bus> items=List.generate(0, (index) => new Bus());
        List list=item['data'];

        list.forEach((element) {
          Bus bus=new Bus();
          bus.id=element['id'].toString();
          bus.placa=element['placa'].toString();
          bus.modelo=element['modelo'].toString();
          bus.cantidad_asientos=element['cantidad_asientos'].toString();
          bus.fecha_asignacion=element['fecha_asignacion'].toString();
          bus.fecha_baja=element['fecha_baja'].toString();
          bus.numero_interno=element['numero_interno'].toString();
          bus.esta_en_recorrido=element['esta_en_recorrido'].toString();
          bus.user_id=element['user_id'].toString();
          bus.bus_route_id=element['bus_route_id'].toString();

          items.add(bus);
        });

        dataResponse.data=items;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> store(String token,Bus bus) async{
    DataResponse dataResponse=new DataResponse();
    try {

      var url = Uri.parse(host+'/api/bus');
      var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      bus.toMapStore().forEach((key, value) {
        request.fields[key]=value;
      });




      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);

      if (kDebugMode) {
        print(result);
      }
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(result);
      if (response.statusCode == 200) {

        var element=item['data'];

        Bus bus=new Bus();
        bus.id=element['id'].toString();
          bus.placa=element['placa'].toString();
          bus.modelo=element['modelo'].toString();
          bus.cantidad_asientos=element['cantidad_asientos'].toString();
          bus.fecha_asignacion=element['fecha_asignacion'].toString();
          bus.fecha_baja=element['fecha_baja'].toString();
          bus.numero_interno=element['numero_interno'].toString();
          bus.esta_en_recorrido=element['esta_en_recorrido'].toString();
          bus.user_id=element['user_id'].toString();
          bus.bus_route_id=element['bus_route_id'].toString();


        dataResponse.data=bus;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> show(String token,String id) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/bus/'+id);
      final http.Response response =await http.get(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {

        var element=item['data'];

        Bus bus=new Bus();
        bus.id=element['id'].toString();
          bus.placa=element['placa'].toString();
          bus.modelo=element['modelo'].toString();
          bus.cantidad_asientos=element['cantidad_asientos'].toString();
          bus.fecha_asignacion=element['fecha_asignacion'].toString();
          bus.fecha_baja=element['fecha_baja'].toString();
          bus.numero_interno=element['numero_interno'].toString();
          bus.esta_en_recorrido=element['esta_en_recorrido'].toString();
          bus.user_id=element['user_id'].toString();
          bus.bus_route_id=element['bus_route_id'].toString();


        dataResponse.data=bus;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> update(String token,Bus bus) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/bus/'+bus.id);
            var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      bus.toMapUpdate().forEach((key, value) {
        request.fields[key]=value;
      });
      request.fields['_method']="PUT";



      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);

      if (kDebugMode) {
        print(result);
      }
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(result);
      if (response.statusCode == 200) {
        var element=item['data'];

        Bus bus=new Bus();
        bus.id=element['id'].toString();
          bus.placa=element['placa'].toString();
          bus.modelo=element['modelo'].toString();
          bus.cantidad_asientos=element['cantidad_asientos'].toString();
          bus.fecha_asignacion=element['fecha_asignacion'].toString();
          bus.fecha_baja=element['fecha_baja'].toString();
          bus.numero_interno=element['numero_interno'].toString();
          bus.esta_en_recorrido=element['esta_en_recorrido'].toString();
          bus.user_id=element['user_id'].toString();
          bus.bus_route_id=element['bus_route_id'].toString();


        dataResponse.data=bus;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> delete(String token,String id) async{
    DataResponse dataResponse=new DataResponse();
    try {
      var url = Uri.parse(host+'/api/bus/'+id);
      final http.Response response =await http.delete(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);

      dataResponse.status=response.statusCode == 200;
      dataResponse.message=item['message'];
    }catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
      dataResponse.message=error.toString();
    }

    return dataResponse;
  }

}

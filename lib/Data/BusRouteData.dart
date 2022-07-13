import 'dart:convert';
import 'dart:io';

import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/BusRoute.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:flutter/foundation.dart';

class BusRouteData{

  Future<DataResponse> index(String token ) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/busroute');
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      if (kDebugMode) {
        print(response.body);
      }
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<BusRoute> items=List.generate(0, (index) => new BusRoute());
        List list=item['data'];

        list.forEach((element) {
          BusRoute busroute=new BusRoute();
          busroute.id=element['id'].toString();
          busroute.line=element['line'].toString();

          items.add(busroute);
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

  Future<DataResponse> store(String token,BusRoute busroute) async{
    DataResponse dataResponse=new DataResponse();
    try {

      var url = Uri.parse(host+'/api/busroute');
      var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      busroute.toMapStore().forEach((key, value) {
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

        BusRoute busroute=new BusRoute();
        busroute.id=element['id'].toString();
          busroute.line=element['line'].toString();


        dataResponse.data=busroute;
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
      var url = Uri.parse(host+'/api/busroute/'+id);
      final http.Response response =await http.get(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {

        var element=item['data'];

        BusRoute busroute=new BusRoute();
        busroute.id=element['id'].toString();
          busroute.line=element['line'].toString();


        dataResponse.data=busroute;
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

  Future<DataResponse> update(String token,BusRoute busroute) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/busroute/'+busroute.id);
            var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      busroute.toMapUpdate().forEach((key, value) {
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

        BusRoute busroute=new BusRoute();
        busroute.id=element['id'].toString();
          busroute.line=element['line'].toString();


        dataResponse.data=busroute;
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
      var url = Uri.parse(host+'/api/busroute/'+id);
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

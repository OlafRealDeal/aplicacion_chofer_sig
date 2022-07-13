import 'dart:convert';
import 'dart:io';

import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/ExitPoint.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:flutter/foundation.dart';

class ExitPointData{

  Future<DataResponse> index(String token ,bus_route_id) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/exitpoint'+'?bus_route_id='+bus_route_id);
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      if (kDebugMode) {
        print(response.body);
      }
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<ExitPoint> items=List.generate(0, (index) => new ExitPoint());
        List list=item['data'];

        list.forEach((element) {
          ExitPoint exitpoint=new ExitPoint();
          exitpoint.id=element['id'].toString();
          exitpoint.lat=element['lat'].toString();
          exitpoint.long=element['long'].toString();
          exitpoint.bus_route_id=element['bus_route_id'].toString();

          items.add(exitpoint);
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

  Future<DataResponse> store(String token,ExitPoint exitpoint) async{
    DataResponse dataResponse=new DataResponse();
    try {

      var url = Uri.parse(host+'/api/exitpoint');
      var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      exitpoint.toMapStore().forEach((key, value) {
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

        ExitPoint exitpoint=new ExitPoint();
        exitpoint.id=element['id'].toString();
          exitpoint.lat=element['lat'].toString();
          exitpoint.long=element['long'].toString();
          exitpoint.bus_route_id=element['bus_route_id'].toString();


        dataResponse.data=exitpoint;
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
      var url = Uri.parse(host+'/api/exitpoint/'+id);
      final http.Response response =await http.get(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {

        var element=item['data'];

        ExitPoint exitpoint=new ExitPoint();
        exitpoint.id=element['id'].toString();
          exitpoint.lat=element['lat'].toString();
          exitpoint.long=element['long'].toString();
          exitpoint.bus_route_id=element['bus_route_id'].toString();


        dataResponse.data=exitpoint;
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

  Future<DataResponse> update(String token,ExitPoint exitpoint) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/exitpoint/'+exitpoint.id);
            var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      exitpoint.toMapUpdate().forEach((key, value) {
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

        ExitPoint exitpoint=new ExitPoint();
        exitpoint.id=element['id'].toString();
          exitpoint.lat=element['lat'].toString();
          exitpoint.long=element['long'].toString();
          exitpoint.bus_route_id=element['bus_route_id'].toString();


        dataResponse.data=exitpoint;
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
      var url = Uri.parse(host+'/api/exitpoint/'+id);
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

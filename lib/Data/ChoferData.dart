import 'dart:convert';
import 'dart:io';

import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/Chofer.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:flutter/foundation.dart';

class ChoferData{

  Future<DataResponse> index(String token ,user_id) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/chofer'+'?user_id='+user_id);
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      if (kDebugMode) {
        print(response.body);
      }
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<Chofer> items=List.generate(0, (index) => new Chofer());
        List list=item['data'];

        list.forEach((element) {
          Chofer chofer=new Chofer();
          chofer.id=element['id'].toString();
          chofer.ci=element['ci'].toString();
          chofer.fecha_nacimiento=element['fecha_nacimiento'].toString();
          chofer.sexo=element['sexo'].toString();
          chofer.telefono=element['telefono'].toString();
          chofer.categoria_licencia=element['categoria_licencia'].toString();
          chofer.foto=element['foto'].toString();
          chofer.user_id=element['user_id'].toString();

          items.add(chofer);
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

  Future<DataResponse> store(String token,Chofer chofer) async{
    DataResponse dataResponse=new DataResponse();
    try {

      var url = Uri.parse(host+'/api/chofer');
      var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      chofer.toMapStore().forEach((key, value) {
        request.fields[key]=value;
      });


      if (!kIsWeb && chofer.foto!='') {
           File fotoFile=new File(chofer.foto);
           http.ByteStream streamfoto = new http.ByteStream(DelegatingStream.typed(fotoFile.openRead()));
           int lengthfoto = await fotoFile.length();
           var multipartFilefoto = new http.MultipartFile('foto', streamfoto, lengthfoto,filename: basename(fotoFile.path));
           request.files.add(multipartFilefoto);
       }
       if (kIsWeb  && chofer.foto!=''){
           var multipartFilefoto=http.MultipartFile.fromBytes(
           'foto',
           chofer.foto,
           filename: 'image.jpg',
           contentType: MediaType('image', 'jpg'),
           );
           request.files.add(multipartFilefoto);
       }


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

        Chofer chofer=new Chofer();
        chofer.id=element['id'].toString();
          chofer.ci=element['ci'].toString();
          chofer.fecha_nacimiento=element['fecha_nacimiento'].toString();
          chofer.sexo=element['sexo'].toString();
          chofer.telefono=element['telefono'].toString();
          chofer.categoria_licencia=element['categoria_licencia'].toString();
          chofer.foto=element['foto'].toString();
          chofer.user_id=element['user_id'].toString();


        dataResponse.data=chofer;
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
      var url = Uri.parse(host+'/api/chofer/'+id);
      final http.Response response =await http.get(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {

        var element=item['data'];

        Chofer chofer=new Chofer();
        chofer.id=element['id'].toString();
          chofer.ci=element['ci'].toString();
          chofer.fecha_nacimiento=element['fecha_nacimiento'].toString();
          chofer.sexo=element['sexo'].toString();
          chofer.telefono=element['telefono'].toString();
          chofer.categoria_licencia=element['categoria_licencia'].toString();
          chofer.foto=element['foto'].toString();
          chofer.user_id=element['user_id'].toString();


        dataResponse.data=chofer;
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

  Future<DataResponse> update(String token,Chofer chofer) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/chofer/'+chofer.id);
            var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      chofer.toMapUpdate().forEach((key, value) {
        request.fields[key]=value;
      });
      request.fields['_method']="PUT";

      if (!kIsWeb && chofer.foto!='') {
           File fotoFile=new File(chofer.foto);
           http.ByteStream streamfoto = new http.ByteStream(DelegatingStream.typed(fotoFile.openRead()));
           int lengthfoto = await fotoFile.length();
           var multipartFilefoto = new http.MultipartFile('foto', streamfoto, lengthfoto,filename: basename(fotoFile.path));
           request.files.add(multipartFilefoto);
       }
       if (kIsWeb  && chofer.foto!=''){
           var multipartFilefoto=http.MultipartFile.fromBytes(
           'foto',
           chofer.foto,
           filename: 'image.jpg',
           contentType: MediaType('image', 'jpg'),
           );
           request.files.add(multipartFilefoto);
       }


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

        Chofer chofer=new Chofer();
        chofer.id=element['id'].toString();
          chofer.ci=element['ci'].toString();
          chofer.fecha_nacimiento=element['fecha_nacimiento'].toString();
          chofer.sexo=element['sexo'].toString();
          chofer.telefono=element['telefono'].toString();
          chofer.categoria_licencia=element['categoria_licencia'].toString();
          chofer.foto=element['foto'].toString();
          chofer.user_id=element['user_id'].toString();


        dataResponse.data=chofer;
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
      var url = Uri.parse(host+'/api/chofer/'+id);
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

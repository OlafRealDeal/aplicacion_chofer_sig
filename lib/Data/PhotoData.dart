import 'dart:convert';
import 'dart:io';

import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/Photo.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:flutter/foundation.dart';

class PhotoData{

  Future<DataResponse> index(String token ,bus_id) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/photo'+'?bus_id='+bus_id);
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      if (kDebugMode) {
        print(response.body);
      }
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<Photo> items=List.generate(0, (index) => new Photo());
        List list=item['data'];

        list.forEach((element) {
          Photo photo=new Photo();
          photo.id=element['id'].toString();
          photo.image=element['image'].toString();
          photo.bus_id=element['bus_id'].toString();

          items.add(photo);
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

  Future<DataResponse> store(String token,Photo photo) async{
    DataResponse dataResponse=new DataResponse();
    try {

      var url = Uri.parse(host+'/api/photo');
      var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      photo.toMapStore().forEach((key, value) {
        request.fields[key]=value;
      });


      if (!kIsWeb && photo.image!='') {
           File imageFile=new File(photo.image);
           http.ByteStream streamimage = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
           int lengthimage = await imageFile.length();
           var multipartFileimage = new http.MultipartFile('image', streamimage, lengthimage,filename: basename(imageFile.path));
           request.files.add(multipartFileimage);
       }
       if (kIsWeb  && photo.image!=''){
           var multipartFileimage=http.MultipartFile.fromBytes(
           'image',
           photo.image,
           filename: 'image.jpg',
           contentType: MediaType('image', 'jpg'),
           );
           request.files.add(multipartFileimage);
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

        Photo photo=new Photo();
        photo.id=element['id'].toString();
          photo.image=element['image'].toString();
          photo.bus_id=element['bus_id'].toString();


        dataResponse.data=photo;
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
      var url = Uri.parse(host+'/api/photo/'+id);
      final http.Response response =await http.get(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {

        var element=item['data'];

        Photo photo=new Photo();
        photo.id=element['id'].toString();
          photo.image=element['image'].toString();
          photo.bus_id=element['bus_id'].toString();


        dataResponse.data=photo;
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

  Future<DataResponse> update(String token,Photo photo) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/photo/'+photo.id);
            var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      photo.toMapUpdate().forEach((key, value) {
        request.fields[key]=value;
      });
      request.fields['_method']="PUT";

      if (!kIsWeb && photo.image!='') {
           File imageFile=new File(photo.image);
           http.ByteStream streamimage = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
           int lengthimage = await imageFile.length();
           var multipartFileimage = new http.MultipartFile('image', streamimage, lengthimage,filename: basename(imageFile.path));
           request.files.add(multipartFileimage);
       }
       if (kIsWeb  && photo.image!=''){
           var multipartFileimage=http.MultipartFile.fromBytes(
           'image',
           photo.image,
           filename: 'image.jpg',
           contentType: MediaType('image', 'jpg'),
           );
           request.files.add(multipartFileimage);
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

        Photo photo=new Photo();
        photo.id=element['id'].toString();
          photo.image=element['image'].toString();
          photo.bus_id=element['bus_id'].toString();


        dataResponse.data=photo;
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
      var url = Uri.parse(host+'/api/photo/'+id);
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

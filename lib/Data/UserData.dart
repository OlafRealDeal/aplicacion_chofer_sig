import 'dart:convert';

import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Entities/User.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

class UserData{


  Future<DataResponse> login(String email,String password) async{
    DataResponse dataResponse=new DataResponse();
    try{
      var url = Uri.parse(host+'/api/login');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' },
          body: {'email': email, 'password': password});
      
      if (kDebugMode) {
        print(response.body);
      }
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);

      if (response.statusCode == 200) {
        var data=item['data'];

        User user=new User();
        user.id=data['id'].toString();
        user.name=data['name'];
        user.email=data['email'];
        user.token=item['token'];

        dataResponse.data=user;
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

  Future<DataResponse> signup(String name,String email,String password,String passwordConfirm) async{
    DataResponse dataResponse=new DataResponse();

    try{
      var url = Uri.parse(host+'/api/signup');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' },
          body: {'name': name,'email': email, 'password': password , 'password_confirm': passwordConfirm});

      if (kDebugMode) {
        print(response.body);
      }
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        var data=item['data'];

        User user=new User();
        user.id=data['id'].toString();
        user.name=data['name'];
        user.email=data['email'];
        user.token=item['token'];

        dataResponse.data=user;
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

  Future<DataResponse> logout(String _token) async{
    DataResponse dataResponse=new DataResponse();
    try{
      var url = Uri.parse(host+'/api/logout');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+_token },
          body: { });

      if (kDebugMode) {
        print(response.body);
      }
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

  //////////////////////////////////////////////////////////////////////////////////////////
  Future<DataResponse> index(String token) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/user');
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      if (kDebugMode) {
        print(response.body);
      }
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<User> items=List.generate(0, (index) => new User());
        List list=item['data'];

        list.forEach((element) {
          User user=new User();
          user.id=element['id'].toString();
          user.name=element['name'].toString();
          user.email=element['email'].toString();

          items.add(user);
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

  Future<DataResponse> store(String token,User user) async{
    DataResponse dataResponse=new DataResponse();
    try {

      var url = Uri.parse(host+'/api/user');
      var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
            
      request.fields['name']=user.name;
      request.fields['email']=user.email;
      request.fields['password']=user.password;


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

        User user=new User();
        user.id=element['id'].toString();
        user.name=element['name'].toString();
        user.email=element['email'].toString();


        dataResponse.data=user;
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
      var url = Uri.parse(host+'/api/user/'+id);
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {

        var element=item['data'];

        User user=new User();
        user.id=element['id'].toString();
        user.name=element['name'].toString();
        user.email=element['email'].toString();


        dataResponse.data=user;
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

  Future<DataResponse> update(String token,User user) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/user/'+user.id);
      var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      user.toMapUpdate().forEach((key, value) {
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

        User user=new User();
        user.id=element['id'].toString();
        user.name=element['name'].toString();
        user.email=element['email'].toString();


        dataResponse.data=user;
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
      var url = Uri.parse(host+'/api/user/'+id);
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
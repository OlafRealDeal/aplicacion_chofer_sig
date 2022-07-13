import 'dart:convert';

import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Data/UserData.dart';
import 'package:aplicacion_chofer_sig/Entities/User.dart';
import 'package:aplicacion_chofer_sig/Session/UserSession.dart';


class UserBusiness{
  UserData userData=new UserData();

  Future<DataResponse> login(String email,String password) async{
    DataResponse response=await this.userData.login(email,password);
    if (response.status){
      User usr=response.data;
      await UserSession.setSession(usr);
    }
    return response;
  }

  Future<DataResponse> signup(String name,String email,String password,String passwordConfirm) async{
    DataResponse dataResponse=new DataResponse();

    if (password!=passwordConfirm){
      dataResponse.status=false;
      dataResponse.message='La contraseña y la confirmacion no son iguales';
      return dataResponse;
    }

    dataResponse=await this.userData.signup(name,email,password,passwordConfirm);
    if (dataResponse.status){
      User usr=dataResponse.data;
      await UserSession.setSession(usr);
    }

    return dataResponse;
  }

  Future<DataResponse> logout() async{
    DataResponse dataResponse=await this.userData.logout(UserSession.user.token);
    User usr=new User();
    if (dataResponse.status){
      await UserSession.setSession(usr);
    }
    if (dataResponse.message=="Unauthenticated."){
      await UserSession.setSession(usr);
    }
    return dataResponse;
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<DataResponse> index() async{

    DataResponse dataResponse=await userData.index(UserSession.user.token);
    return dataResponse;
  }

  Future<DataResponse> store(name,email,password) async{
    User user=new User();
    user.name=name;
    user.email=email;
    user.password=password;

    DataResponse dataResponse=await userData.store(UserSession.user.token,user);
    return dataResponse;
  }

  Future<DataResponse> update(User user) async{
    DataResponse dataResponse=await userData.update(UserSession.user.token,user);
    return dataResponse;
  }

  Future<DataResponse> delete(String id) async{
    return await userData.delete(UserSession.user.token,id);
  }
}
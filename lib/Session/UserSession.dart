import 'package:aplicacion_chofer_sig/Entities/User.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UserSession{
  static final UserSession _instance = UserSession._internal();
  factory UserSession() => _instance;

  static User user=new User();

  UserSession._internal() {
    // init things inside this
  }

  static UserSession get shared => _instance;

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static getSession()async{
    User user=new User();
    final SharedPreferences prefs = await _prefs;

    user.id=prefs.getString('id') ?? '';
    user.name=prefs.getString('name') ?? '';
    user.email=prefs.getString('email') ?? '';
    user.token=prefs.getString('token') ?? '';

    UserSession.user=user;
  }

  static setSession(User user)async{
    final SharedPreferences prefs = await _prefs;

    await prefs.setString('id', user.id);
    await prefs.setString('name', user.name);
    await prefs.setString('email', user.email);
    await prefs.setString('token', user.token);

    UserSession.user=user;
  }
}
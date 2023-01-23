import 'dart:async';
import 'package:flutter/material.dart';


import 'package:firebase/screen/login_scr.dart';
import 'package:flutter/material.dart';
class SplashServices{
  void isLogin(BuildContext context){
   Timer(const Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>const LoginPage())));
  }
}
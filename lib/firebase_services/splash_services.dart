import 'dart:async';
import 'package:firebase/screen/firestore/fire_store_scr.dart';
import 'package:firebase/screen/posts/post_scr.dart';
import 'package:firebase/screen/upload_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:firebase/screen/login_scr.dart';
import 'package:flutter/material.dart';
class SplashServices{
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user !=null){
      Timer(const Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>const PostScreen())));
    }
    else{
      Timer(const Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>const LoginPage())));
    }
    }

}
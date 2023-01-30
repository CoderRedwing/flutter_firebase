import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @ override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: Drawer(
         child: Column(
           children: const [
             CircleAvatar(
               child: Text("hi i am ajitesh"),
             )
           ],
         ),
       ),
      appBar: AppBar(
        elevation: 0,

      ),

    );
  }
}

import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool loading = false;
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
            SizedBox(height: 45,),
            RoundButton(title: 'Forgot',loading: loading, onTap: (){
              setState(() {
                loading=true;
              });
             auth.sendPasswordResetEmail(
                 email: emailController.text.toString(),


             ).then((value) {
               setState(() {
                 loading=true;
               });
               Utils().toastMessage('We have sent you a link on email please check');
             }).onError((error, stackTrace) {
               Utils().toastMessage(error.toString());
               setState(() {
                 loading=true;
               });
             });
            }),
          ],
        ),
      ),
    );
  }
}


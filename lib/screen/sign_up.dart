import 'package:firebase/screen/login_scr.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);


  @override
  State<SignupPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(


          title: Text("Signup"),
        ),
        body: Padding(

          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,

                        decoration: const InputDecoration(
                          hintText: 'Email',

                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter email ';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',


                          prefixIcon: Icon(Icons.lock_open),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter password ';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 40,

              ),
              RoundButton(title: 'Signup', onTap: () {
                if(_formKey.currentState!.validate()){
                   auth.createUserWithEmailAndPassword(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString(),);
                }
              },),
              const SizedBox(
                height: 40,

              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>LoginPage(),)
                      );
                    },
                        child: Text('Login')),
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}

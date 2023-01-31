import 'package:firebase/screen/sign_up.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Text("Login"),
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
            RoundButton(title: 'Login', onTap: () {
              if(_formKey.currentState!.validate()){

              }
            },),
            const SizedBox(
              height: 40,

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>SignupPage(),)
                  );
                },
                    child: Text('Sign up')),

              ]
            )
          ],
        ),
      ),
    );
  }
}

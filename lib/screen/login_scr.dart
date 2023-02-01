import 'package:firebase/screen/login_phone.dart';
import 'package:firebase/screen/posts/post_scr.dart';
import 'package:firebase/screen/sign_up.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void login(){
    setState(() {
      loading =true;
    });
    _auth.signInWithEmailAndPassword(email: emailController.text,
        password: passwordController.text.toString()).then((value){

          Utils().toastMessage(value.user!.email.toString());
           Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen(),));
          setState(() {
            loading =true;
          });
    }).onError((error, stackTrace){

      debugPrint(error.toString());
     Utils().toastMessage(error.toString());
      setState(() {
        loading =true;
      });
    });

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
            RoundButton(title: 'Login',loading: loading, onTap: () {
              if(_formKey.currentState!.validate()){
                 login();
              }
            },),
            const SizedBox(
              height: 40,

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>const SignupPage(),)
                  );
                },
                    child: const Text('Sign up')),
                const SizedBox(height: 35,),


              ]
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginWithPhone()));
              },
              child: Container(
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(40),

                  border: Border.all(
                    color: Colors.black,
                  )
                ),
                height: 50,
                child: const Center(
                  child: Text('Login with phone'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

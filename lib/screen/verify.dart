import 'package:firebase/screen/posts/post_scr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/utils.dart';
import '../widgets/round_button.dart';

class VerifyScreen extends StatefulWidget {
 final String verificationId;
  const VerifyScreen({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }
  bool loading = false;
  final verifyController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 100,),
            TextFormField(

              controller: verifyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: '6 digit code'
              ),
            ),
            const SizedBox(height: 80,),
            RoundButton(title: 'Verify', loading: loading, onTap: () async{
              setState(() {
                loading = true;
              });
            final crendital = PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: verifyController.text.toString(),
            );
            try{
             await auth.signInWithCredential(crendital);
             Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
            }catch(e){
              setState(() {
                loading = false;
              });
              Utils().toastMessage(e.toString());
            }
            })
          ],
        ),
      ),
    );
  }
}

import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children:  [
              const SizedBox(
                height: 30,
              ),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: const InputDecoration(
                hintText: 'What in your minds',
                border: OutlineInputBorder(),

              ),
            ),
            const SizedBox(height: 35,),
            RoundButton(title: 'Add',loading: loading, onTap: (){
              setState(() {
                loading=true;
              });
                 databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).child('comments').set({

                   'title':postController.text.toString(),
                   'id':DateTime.now().millisecondsSinceEpoch.toString()

                 }).then((value) {

                   Utils().toastMessage('Post added');
                   setState(() {
                     loading=false;
                   });
                 }).onError((error, stackTrace){

                   Utils().toastMessage(error.toString());
                   setState(() {
                     loading=false;
                   });
                 });
            }),
          ],
        ),
      ),
    );
  }
}


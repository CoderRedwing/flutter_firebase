import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddFireStoreData extends StatefulWidget {
  const AddFireStoreData({Key? key}) : super(key: key);

  @override
  State<AddFireStoreData> createState() => _AddFireStoreDataState();
}

class _AddFireStoreDataState extends State<AddFireStoreData> {
  final postController = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Firestore Data'),
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
              String id = DateTime.now().millisecondsSinceEpoch.toString();
           fireStore.doc(id).set({
           'title':postController.text.toString(),
             'id':id
           }).then((value) {
             Utils().toastMessage('post added');
             setState(() {
               loading=false;
             });
           }).onError((error, stackTrace) {
            Utils().toastMessage(error.toString());
            setState(() {
              loading=false;
            });
           });

              })

          ],
        ),
      ),
    );
  }

}


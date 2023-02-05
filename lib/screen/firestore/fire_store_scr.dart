import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screen/firestore/add_firestore_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase/screen/login_scr.dart';
import 'package:firebase/screen/posts/add_post.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  @override
  final auth = FirebaseAuth.instance;

  final editController =TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('Users').snapshots();
  CollectionReference ref =FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(

        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Firestore'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          }, icon: const Icon(Icons.logout_outlined)),
          const SizedBox(width: 15,),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
               return CircularProgressIndicator();
              }
              if(snapshot.hasError)
                return Text('Some error');
              return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          onTap: (){
                            ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                            'title':'ajitesh hello'
                            }).then((value) {
                              Utils().toastMessage('Updated');
                            }).onError((error, stackTrace) {
                             Utils().toastMessage(error.toString());
                            });
                            ref..doc(snapshot.data!.docs[index]['id'].toString()).delete();
                          },
                          title: Text(snapshot.data!.docs[index]['title'].toString()),
                          subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                        );
                      })
              );
              })

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFireStoreData(),));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> showMyDialog(String title,String id)async{
    editController.text=title;
    return showDialog(
      context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update'),
        content: Container(
          child: TextField(
            controller: editController,
            decoration: InputDecoration(
                hintText: 'Edit'
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          },
              child: Text('Cancel')),
          TextButton(onPressed: (){
            Navigator.pop(context);

          },
              child: Text('Update')),
        ],
      );

    },

    );
  }
}


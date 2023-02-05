import 'dart:io';

import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class UploadImages extends StatefulWidget {
  const UploadImages({Key? key}) : super(key: key);

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  bool loading =false;
  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
      DatabaseReference    databaseRef = FirebaseDatabase.instance.ref('Post');
  Future getImageGallery()async{
       final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
       setState(() {
         if(pickedFile!=null){
           _image =File(pickedFile.path);
         }else{
           print('no image pikked');
         }
       });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload images'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
               getImageGallery();
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple,
                      style: BorderStyle.solid,
                      )

                    ),

                  child: _image!=null?Image.file(_image!.absolute):
                  Icon(Icons.image,size: 60,color: Colors.deepPurple,),
                ),
              ),

            ),
            SizedBox(height: 30,),
            RoundButton(

                title: 'Upload',loading: loading, onTap: ()async{
                  setState(() {
                    loading=true;
                  });
                  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/ajitesh/'+DateTime.now().millisecondsSinceEpoch.toString());
                  firebase_storage.UploadTask uploadTask =ref.putFile(_image!.absolute);
                  await Future.value(uploadTask).then((value)async{

                  });
                  var newUrl=await ref.getDownloadURL();
                  databaseRef.child('1').set({
                    'id': '2222',
                    'title':newUrl.toString(),
                  }).then((value) {
                    setState(() {
                      loading=false;
                    });
                    Utils().toastMessage('Uploaded');
                  }).onError((error, stackTrace) {
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


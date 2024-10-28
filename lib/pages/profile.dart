import 'dart:io';

import 'package:ecommerce/pages/login.dart';
import 'package:ecommerce/pages/signUp.dart';
import 'package:ecommerce/service/auth.dart';
import 'package:ecommerce/service/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/service/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;

  final ImagePicker _picker = ImagePicker();

  File? selectedImage;

  Future getImage()async{
    var image = (await _picker.pickImage(source: ImageSource.gallery)) as File;
    selectedImage = File(image.path);
    setState(() {
      uploadItem();
    });
  }

  uploadItem()async{
    if(selectedImage != null){
      String addId = randomAlphaNumeric(10);
      final firebaseStorageRef = FirebaseStorage.instance.ref().child("BlogImage").child(addId);

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      String downloadurl = await (await task).ref.getDownloadURL();
      await SharedPreferenceHelper().savedUserProfile(downloadurl);
      setState(() {

      });
    }
  }

  getsharedpref()async{
    profile = await SharedPreferenceHelper().getUserProfile();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserMail();
  }

  onthisLoad()async{
    await getsharedpref();
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    onthisLoad();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /*name==null? CircularProgressIndicator():*/Stack(children: [
        Material(
          elevation: 40,
          child: Container(
            margin: EdgeInsets.only(bottom: 600),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(MediaQuery.of(context).size.width, 130),
              )
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 55,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(name!, style: TextStyle(fontSize: 30, fontFamily: "Pippins", color: Colors.white),),
          ]
          )
        ),
        Padding(
          padding: EdgeInsets.only(top: 140),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: selectedImage==null? GestureDetector(
                        onTap: (){
                          getImage();
                        },
                        child: profile==null?
                        Icon(Icons.camera_alt_outlined, color: Colors.black, size: 40,):
                        Image.network(profile!, height: 130, width: 130, fit: BoxFit.cover,),
                      ): Image.file(selectedImage!, height: 130, width: 130, fit: BoxFit.cover,),
                    )
                ),
            ],
          )
        ),
        /*
        Center(
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 6.5),
            child: Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(60),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: selectedImage==null?  GestureDetector(
                  onTap: (){
                    getImage();
                  },
                  child: profile==null? Icon(Icons.camera_alt_outlined, color: Colors.black, size: 40,):
                  Image.network(
                    profile!,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ): Image.file(selectedImage!,  height: 120,
                  width: 120,
                  fit: BoxFit.cover,),
              ),
            ),
          ),
        ),

         */
        Padding(
          padding: EdgeInsets.only(right: 10, left: 10, top: 300),
          child: Column(children: [
            Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(children: [
                  Icon(Icons.person, size: 35, color: Colors.black,),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Name", style: TextStyle(fontSize: 20, fontFamily: "Poppins"),),
                    Text(name!, style: TextStyle(fontSize: 20, fontFamily: "Poppins"),),
                  ],)
                ],),
              ),
            ),
            SizedBox(height: 20,),
            Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(children: [
                  Icon(Icons.email, size: 35, color: Colors.black,),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email", style: TextStyle(fontSize: 20, fontFamily: "Poppins"),),
                      Text(email!, style: TextStyle(fontSize: 20, fontFamily: "Poppins"),),
                    ],)
                ],),
              ),
            ),
            SizedBox(height: 20,),
            Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(children: [
                  Icon(Icons.document_scanner, size: 35, color: Colors.black,),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Term and condition", style: TextStyle(fontSize: 21, fontFamily: "Poppins"),),
                    ],)
                ],),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                AuthMethods().DeleteUser();
              },
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(children: [
                    Icon(Icons.delete_forever, size: 35, color: Colors.black,),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Delete Account", style: TextStyle(fontSize: 21, fontFamily: "Poppins"),),
                      ],)
                  ],),
                ),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                AuthMethods().SignOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
              },
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(children: [
                    Icon(Icons.logout, size: 35, color: Colors.black,),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Logout", style: TextStyle(fontSize: 21, fontFamily: "Poppins"),),
                      ],)
                  ],),
                ),
              ),
            ),
          ],
          ),
        ),
      ],
      ),
    );
  }
}

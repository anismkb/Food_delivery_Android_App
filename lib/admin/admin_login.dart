import 'package:ecommerce/admin/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  String Password="", Username="";
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Container(
        margin: EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Stack(children: [
            Text("Let's start with Admin !", style: TextStyle(fontFamily: "Poppins", fontSize: 30, ),),
            Container(
              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/6,
                  left: 30, right: 30, bottom: MediaQuery.of(context).size.height/3),
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child:Center(child:
                Container(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: usernamecontroller,
                            validator:(value){
                              if(value==null || value.isEmpty){
                                return "Pleas enter your username";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Username',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 35,),
                          TextFormField(
                            controller: passwordcontroller,
                            validator: (value){
                              if(value==null || value.isEmpty){
                                 return "Enter a password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 35,),
                          GestureDetector(
                            onTap: (){
                              LoginAmin();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black ),
                              child: Center(
                                child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                              )
                            ),
                          )
                        ],
                      )
                  ),
                )
              )
            ),

        ],),
      ),
    );
  }

  LoginAmin(){
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot){
      snapshot.docs.forEach((result){
        if(result.data()['id']!=usernamecontroller.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Your Id is not correct",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        }else if(result.data()['password']!=passwordcontroller.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "The password is incorrect",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
      }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Admin_Home()));
        }
    });
  });
  }
}

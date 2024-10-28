import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/pages/signUp.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {

  TextEditingController emailcontroller = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String mail="";

  resetePassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: mail);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Reset Email has been sent !", style: TextStyle(fontSize: 18.0, color: Colors.green),),));
    }on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The mail dosn't exist !", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),));
      }else if(e.code=="invalid-email"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The email adresse is badly formatted !", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.redAccent),),));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(child: Column(children: [
        SizedBox(height: 70,),
        Container(
          alignment: Alignment.topCenter,
          child: Text("Reset Password", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.topCenter,
          child: Text("Enter your Email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
        ),
        SizedBox(height: 60.0,),
        //Container(
          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        //)
        Expanded(
          child: Form(
              key: _formkey,
              child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      controller: emailcontroller,
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Entre your Email";
                        }
                        return null;
                      },
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                        prefixIcon: Icon(Icons.person, color: Colors.white70, size: 30,),
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  GestureDetector(
                    onTap: (){
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          mail=emailcontroller.text;
                        });
                        resetePassword();
                      }
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text("Send Email", style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                          },
                          child: Text("Don't have an account? Create one", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)
                        ),
                      ]
                    )
                  )
                ],
              ),
          )),
        )

      ],),
      ),
    );
  }
}

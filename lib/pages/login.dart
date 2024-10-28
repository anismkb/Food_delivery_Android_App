
import 'package:ecommerce/pages/ForgetPassword.dart';
import 'package:ecommerce/pages/signUp.dart';
import 'package:ecommerce/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/pages/bottomnav.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email =""; String password="";

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Login ()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Bottomnav()));
    }on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No user found for this email", style: TextStyle(fontSize: 18.0, color: Colors.black),)));
      }else if(e.code=="wrong-password"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong password", style: TextStyle(fontSize: 18.0, color: Colors.black),)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange,
                  Colors.deepOrange,
                ]
              )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.white),
            child: Text(""),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top :30,),
                child: Image.asset("images/logo.png", width: 80, height: 80,),
              ),
            ]
          ),

          Positioned(
            top: MediaQuery.of(context).size.height/5,
            left: 50,
            right: 50,
            bottom: MediaQuery.of(context).size.height/6,
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(17),
              child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key : _formkey,
                        child: Column(
                          children: [
                            Text("Login", style: AppWidget.HeadLineTextFeildStyle(),),
                            SizedBox(height: 40,),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: emailcontroller,
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return 'Please Enter an Email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: AppWidget.boldTextFeildStyle(),
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                            ),
                            SizedBox(height: 40,),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child:
                              TextFormField(
                                controller: passwordcontroller,
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return 'Please Enter an Email';
                                  }
                                  return null;
                                },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: AppWidget.boldTextFeildStyle(),
                                    prefixIcon: Icon(Icons.password_outlined),
                                  )),
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: 25,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgetpassword()));
                        },
                        child: Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(right: 20),
                          child: Text("Forgot password ?", style: AppWidget.boldTextFeildStyle(),),
                        ),
                      ),
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: (){
                          if(_formkey.currentState!.validate()){
                            setState(() {
                              email = emailcontroller.text;
                              password = passwordcontroller.text;
                            });
                          }
                          Login();
                        },
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xffff5722), borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.only(left: 50, right: 50, bottom: 10, top: 10),
                            child: Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Poppins1', fontWeight: FontWeight.bold ),),
                          ),
                        ),
                      )
                  ],
                  )
                ),
            ),
          ),
          
          Container(
            margin: EdgeInsets.only(top: 650, left: 45),
            child : GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
              },
              child: Text("D'ont have an account? Sign up", style: AppWidget.boldTextFeildStyle(),)),
          )
        ],)
      ),
    );
  }
}

import 'package:ecommerce/pages/bottomnav.dart';
import 'package:ecommerce/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import '../service/database.dart';
import '../service/shared_pref.dart';
import '../widget/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  String email="", password="", name="";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();

  final _formkey=GlobalKey<FormState>();

  registration() async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email:email, password:password);
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(content:Text("Registred successfully", style: TextStyle(fontSize: 20.0, fontFamily: "Poppins", ),))));

      String id = randomAlphaNumeric(10);
      Map<String, dynamic> addUserInfo={
        "name" : namecontroller.text,
        "email" : emailcontroller.text,
        "wallet" : "0",
        "id" : id,
      };
      await DatabaseMethods().addUserDetail(addUserInfo, id);
      await SharedPreferenceHelper().savedUserId(id);
      await SharedPreferenceHelper().savedUserEmail(emailcontroller.text);
      await SharedPreferenceHelper().savedUserName(namecontroller.text);
      await SharedPreferenceHelper().savedUserWallet("0");

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    }on FirebaseAuthException catch(e){
      if(e.code=='weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.orangeAccent,content: Text("Password provider is too weak", style: TextStyle(fontSize: 18))));
      }else if(e.code=="email-already-in-use"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.orangeAccent,content: Text("Email already existe", style: TextStyle(fontSize: 18),)));
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
              bottom: MediaQuery.of(context).size.height/9,
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
                              Text("Sign up", style: AppWidget.HeadLineTextFeildStyle(),),
                              SizedBox(height: 40,),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: TextFormField(
                                  controller : namecontroller,
                                  validator:(value){
                                    if(value==null || value.isEmpty){
                                      return "please enter a Name";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: AppWidget.boldTextFeildStyle(),
                                    prefixIcon: Icon(Icons.person_2_outlined),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25,),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: TextFormField(
                                  controller : emailcontroller,
                                  validator:(value){
                                    if(value==null || value.isEmpty){
                                      return "please enter an E-mail";
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
                              SizedBox(height: 25,),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child:
                                TextFormField(
                                    controller : passwordcontroller,
                                    validator:(value){
                                      if(value==null || value.isEmpty){
                                        return "please enter a password";
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
                        SizedBox(height: 55,),
                        GestureDetector(
                          onTap: ()async{
                            if (_formkey.currentState!.validate()){
                              setState(() {
                                email=emailcontroller.text;
                                password=passwordcontroller.text;
                                name=namecontroller.text;
                              });
                            }
                            registration();
                          },
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(color: Color(0xffff5722), borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.only(left: 50, right: 50, bottom: 10, top: 10),
                              child: Text("SIGN UP", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Poppins1', fontWeight: FontWeight.bold ),),
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 670, left: 45),
              child : GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                },
                  child: Text("Already have an account, Sing In !", style: AppWidget.boldTextFeildStyle(),)),
            )
          ],)
      ),
    );
  }
}

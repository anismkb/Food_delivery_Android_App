import 'package:ecommerce/admin/add_food.dart';
import 'package:ecommerce/widget/widget_support.dart';
import 'package:flutter/material.dart';


class Admin_Home extends StatefulWidget {
  const Admin_Home({super.key});

  @override
  State<Admin_Home> createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 40),
          alignment: Alignment.center,
          child: Text("Home Admin", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "Poppins"),),
        ),
        SizedBox(height: 30,),
        GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddFood()));
          },
          child: Container(
            height: 110,
            decoration: BoxDecoration(color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("images/food.jpg", height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width/3),
                  SizedBox(width: 30,),
                  Text("Add Food items", style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20, fontWeight: FontWeight.bold,)),
                ],),
            )


          ),
        )
      ],),
      ),
    );
  }
}

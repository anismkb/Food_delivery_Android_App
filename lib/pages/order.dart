import 'dart:async';

import 'package:ecommerce/service/database.dart';
import 'package:ecommerce/service/shared_pref.dart';
import 'package:flutter/material.dart';

import '../widget/widget_support.dart';


class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {

  String? id, wallet;
  Stream? FoodStream;
  int total=0, amount2=0;

  void startTimer(){
    Timer(Duration(seconds: 1), () {
      amount2 = total;
      setState(() {
      });
    });
  }

  getsharedpref()async{
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getUserWallet();
    setState(() {

    });
  }

  onthload()async{
    await getsharedpref();
    FoodStream=await DatabaseMethods().getFoodCart(id!);
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    onthload();
    startTimer();
    super.initState();
  }

  Widget foodCart(){
    return StreamBuilder(stream: FoodStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData
          ? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
              var ds = snapshot.data.docs[index];
              total = total + int.parse(ds["Total"]);
              return Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
                child: Material(
                  borderRadius: BorderRadius.circular(13),
                  elevation: 7,
                  child: Container(//principal
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(children: [
                      Container(
                          height: 90,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: Colors.black),
                          ),
                          //padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          //margin: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                          child: Center(
                            child: Text(ds["Quantity"], style: TextStyle(fontSize: 20, fontFamily: "Poppins"),),
                          )
                      ),
                      SizedBox(width: 20,),
                      Container(
                        child: Image.network(ds["Image"], height: 90, width: 90,),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ds["Name"], style: TextStyle(fontSize: 16, fontFamily: "Poppins")),
                            Text("\$"+ds["Total"].toString(), style: TextStyle(fontSize: 16, fontFamily: "Poppins")),
                          ],),
                      )
                    ],),
                  ),
                ),
              );
            })
          : CircularProgressIndicator();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60),
        child: Column(children: [
        Material(
          elevation: 7.0,
          child: Container(
              padding: EdgeInsets.only(bottom:5, top: 5),
              child: Center(child: Text("Food Cart", style: AppWidget.HeadLineTextFeildStyle(),),)),
        ),
        SizedBox(height: 20,),
        Container(
          height: MediaQuery.of(context).size.height/2,
          child: foodCart()
        ),
        /*
        Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
          child: Material(
            borderRadius: BorderRadius.circular(13),
            elevation: 7,
            child: Container(//principal
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(children: [
                Container(
                  height: 90,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: Colors.black),
                  ),
                  //padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  //margin: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                  child: Center(
                    child: Text("2", style: TextStyle(fontSize: 20, fontFamily: "Poppins"),),
                  )
                ),
                SizedBox(width: 20,),
                Container(
                  child: Image.asset("images/pizza.png", height: 90, width: 90,),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Pizza Napolitano", style: TextStyle(fontSize: 16, fontFamily: "Poppins")),
                    Text("\$ 20", style: TextStyle(fontSize: 16, fontFamily: "Poppins")),
                  ],),
                )
              ],),
            ),
          ),
        ),
        */
        Spacer(),
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(children: [
            Row(
              children: [
              Text("Total price", style: AppWidget.boldTextFeildStyle(),),
              Spacer(),
              Text("\$"+total.toString(), style: AppWidget.boldTextFeildStyle(),)
            ],
            ),
            GestureDetector(
              onTap: () async {
                int amount = int.parse(wallet!) - amount2;
                await DatabaseMethods().UpdateUserWallet(id!, amount.toString());
                await SharedPreferenceHelper().savedUserWallet(amount.toString());
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(child: Text("CheckOut", style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),),),
              ),
            )
          ],),
        )
      ],),
      ),
    );
  }
}

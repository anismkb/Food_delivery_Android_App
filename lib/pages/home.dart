import 'package:ecommerce/service/database.dart';
import 'package:ecommerce/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'details.dart';
import 'order.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream=false;
  bool pizza=false;
  bool salad=false;
  bool burger=false;

  Stream? foodItemStream;

  ontheload()async{
    foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  Widget allItems(){
    return StreamBuilder(stream: foodItemStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            var ds =snapshot.data.docs[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Details(name: ds["nam"], price: ds["price"], details: ds["details"], image: ds["Image"],)));
              },
              child: Container(
                width: 190,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                      padding: EdgeInsets.all(14.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(ds["Image"], fit: BoxFit.cover,)
                            ),
                            SizedBox(height: 5.0),
                            Text(ds["nam"], style: AppWidget.boldTextFeildStyle()),
                            SizedBox(height: 5.0),
                            Text(ds["details"], style: AppWidget.SemiboldTextFeildStyle()),
                            Text("\$"+ds["price"], style: AppWidget.boldTextFeildStyle(),)
                          ])
                  ),
                ),
              ),
            );
      }):CircularProgressIndicator();
    });
  }

  Widget allItemsVertical(){
    return StreamBuilder(
        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot){
        return snapshot.hasData?
          ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index){
                var ds =snapshot.data.docs[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Details(name: ds["nam"], price: ds["price"], details: ds["details"], image: ds["Image"])));
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(right: 5, bottom: 10,),
                      child:Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(ds["Image"],
                                  height: 110, width: 110,
                                  fit: BoxFit.cover,),
                              ),
                              SizedBox(width: 20.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                Container(
                                  child: Text(ds["nam"], style: AppWidget.boldTextFeildStyle(),),
                                ),
                                SizedBox(height: 10.0,),
                                Text(ds["details"], style: AppWidget.SemiboldTextFeildStyle(),), // Limite le nombre de lignes),
                                SizedBox(height: 10.0,),
                                Container(
                                  child: Text("\$"+ds["price"], style: AppWidget.boldTextFeildStyle(),),
                                )
                              ] )
                            ],
                          ),
                        ),
                      )
                  )
                );
              },
        ):CircularProgressIndicator();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Wolcom clients,",
                  style: AppWidget.boldTextFeildStyle(),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Order()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.shopping_cart, color: Colors.white,)),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text(
              "Delicious food,", style: AppWidget.HeadLineTextFeildStyle(),
            ),
            Text(
              "Descover and get Great Food,",
              style: AppWidget.LightTextFeildStyle(),
            ),
            SizedBox(height: 15,),
            ShowItem(),
            SizedBox(height: 15,),
            Container(
                height: 270,
                child: allItems()
            ),
            SizedBox(height: 30,),
            Expanded(
              child: allItemsVertical(),
            ),
          ],),
      ),
    );
  }

  Widget ShowItem(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          GestureDetector(
            onTap: () async{
              icecream=true;
              pizza=false;
              burger=false;
              salad=false;
              foodItemStream = await DatabaseMethods().getFoodItem("Ic-cream");
              setState(() {

              });
            },
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5.0,
                child: Container(
                  decoration: BoxDecoration(color: icecream? Colors.black:Colors.white, borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(8),
                  child: Image.asset("images/ice-cream.png", height: 50, width: 50, fit: BoxFit.cover, color: icecream? Colors.white:Colors.black,),
                )
            ),
          ),
          GestureDetector(
            onTap: () async{
              icecream=false;
              pizza=true;
              burger=false;
              salad=false;
              foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
              setState(() {

              });
            },
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5.0,
                child: Container(
                  decoration: BoxDecoration(color: pizza? Colors.black:Colors.white, borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(8),
                  child: Image.asset("images/pizza.png", height: 50, width: 50, fit: BoxFit.cover, color: pizza? Colors.white:Colors.black,),
                )
            ),
          ),
          GestureDetector(
            onTap: ()async{
              icecream=false;
              pizza=false;
              burger=true;
              salad=false;
              foodItemStream = await DatabaseMethods().getFoodItem("Burger");
              setState(() {

              });
            },
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5.0,
                child: Container(
                  decoration: BoxDecoration(color: burger? Colors.black:Colors.white, borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(8),
                  child: Image.asset("images/burger.png", height: 50, width: 50, fit: BoxFit.cover, color: burger? Colors.white:Colors.black,),
                )
            ),
          ),
          GestureDetector(
            onTap: ()async{
              icecream=false;
              pizza=false;
              burger=false;
              salad=true;
              foodItemStream = await DatabaseMethods().getFoodItem("Salad");
              setState(() {

              });
            },
            child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5.0,
                child: Container(
                  decoration: BoxDecoration(color: salad? Colors.black:Colors.white, borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(8),
                  child: Image.asset("images/salad.png", height: 50, width: 50, fit: BoxFit.cover, color: salad? Colors.white:Colors.black,),
                )
            ),
          ),
        ]
    );
  }
}



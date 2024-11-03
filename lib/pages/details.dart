
import 'package:ecommerce/service/database.dart';
import 'package:ecommerce/service/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import '../widget/widget_support.dart';
import 'bottomnav.dart';

class Details extends StatefulWidget {

  late String name, price, details, image;
  Details({required this.name, required this.price, required this.details, required this.image});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late int nbcommande=0;
  int total =0;

  late String? Id;
  late String comd;

  getthesharedpref()async{
    Id=await SharedPreferenceHelper().getUserId();
    String? quantity = await DatabaseMethods().getQuantity(widget.name, Id!);
    comd = quantity ?? "0";
    nbcommande=int.parse(comd);
    var totale=await DatabaseMethods().getOrSetTotal(widget.name, Id!);
    total= int.parse(totale);// Attribuez "0" si quantity est null
    setState(() {

    });
  }

  onthload()async{
    await getthesharedpref();
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onthload();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        margin: EdgeInsets.only(top :40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,),
          ),
          SizedBox(height: 20,),
          Image.network(widget.image),
          SizedBox(height: 20,),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name, style: AppWidget.boldTextFeildStyle(),),
                ]
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  nbcommande++;
                  total = total + int.parse(widget.price);
                  setState(() {

                  });
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                  child: Icon(Icons.add, color: Colors.white,),
                ),
              ),
              SizedBox(width: 20,),
              Text(nbcommande.toString(), style: AppWidget.boldTextFeildStyle(),),
              SizedBox(width: 20,),
              GestureDetector(
                onTap: (){
                  if(nbcommande>=1 && total>0){
                    nbcommande--;
                    total = total - int.parse(widget.price);
                  }
                  setState(() {

                  });
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                  child: Icon(Icons.remove, color: Colors.white,),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text(widget.details, style: AppWidget.SemiboldTextFeildStyle(),),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("Delivery Time", style: AppWidget.boldTextFeildStyle()),
              SizedBox(width: 10,),
              Icon(Icons.alarm),
              SizedBox(width: 10,),
              Text("30 min", style: AppWidget.boldTextFeildStyle(),),
            ],
          ),
          Spacer(),
          Row(children: [
            Container(child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total price", style: AppWidget.boldTextFeildStyle(),),
                  Text("\$ "+total.toString(), style: AppWidget.HeadLineTextFeildStyle(),),
                ]
            )
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                // Vérifiez si Id est null avant d'exécuter l'ajout au panier
                Map<String, dynamic> AddfoodToCart = {
                  "Name": widget.name,
                  "Quantity": nbcommande.toString(),
                  "Total": total.toString(),
                  "Image": widget.image,
                };
                //DatabaseMethods().addFoodToCart(AddfoodToCart, Id!);
                DatabaseMethods().AddOrUpdateFoodInCart(AddfoodToCart, Id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Food Added to cart",
                      style: TextStyle(fontSize: 20.0, fontFamily: "Poppins"),
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.black),
                padding: EdgeInsets.only(top:10, bottom: 10, left: 15, right: 15),
                child: Row(children: [
                    Text("Add to cart", style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: "Poppins")),
                    SizedBox(width: 20,),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey,),
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
                    )
                  ]
                )
              ),
            ),
          ],
          ),
          SizedBox(height: 30,),
          ],
        ),

      ),

    );
  }
}

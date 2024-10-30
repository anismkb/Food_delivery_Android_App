import 'dart:convert';

import 'package:ecommerce/service/database.dart';
import 'package:ecommerce/service/shared_pref.dart';
import 'package:ecommerce/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet,id;
  int? add;

  getthesharedpref()async{
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {
    });
  }

  ontheload()async{
    await getthesharedpref();
    setState(() {
    });
  }

  final TextEditingController amountcontroller = new TextEditingController();

  @override
  void initState(){
    ontheload(); //will be called as soon as the app is start
    super.initState();
  }
  
  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet==null? CircularProgressIndicator(): Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(children: [
        Material(
          elevation: 7.0,
          child: Container(
            padding: EdgeInsets.only(bottom:5, top: 5),
            child: Center(child: Text("Wallet", style: AppWidget.HeadLineTextFeildStyle(),),)),
        ),
        SizedBox(height: 30.0),
        Container(
          padding: EdgeInsets.all(7.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
          child:Row(children: [
              Image.asset("images/wallet.png", height: 60, width: 60,),
              SizedBox(width: 40,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your wallet", style: AppWidget.LightTextFeildStyle(),),
                  Text("\$" + wallet!, style: AppWidget.boldTextFeildStyle(),),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 20.0,),
        Padding(padding: EdgeInsets.only(left: 20.0),
          child: Text("Add Money", style: AppWidget.HeadLineTextFeildStyle()),
        ),
        SizedBox(height: 10.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          GestureDetector(
            onTap: (){
              makePayment('100');
            },
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Color(0xFFE9E2E2))),
              child: Text("\$100", style: AppWidget.SemiboldTextFeildStyle(),),
            ),
          ),
          GestureDetector(
            onTap: (){
              makePayment('500');
            },
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Color(0xFFE9E2E2))),
              child: Text("\$500", style: AppWidget.SemiboldTextFeildStyle(),),
            ),
          ),
          GestureDetector(
            onTap: (){
              makePayment('1000');
            },
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Color(0xFFE9E2E2))),
              child: Text("\$1000", style: AppWidget.SemiboldTextFeildStyle(),),
            ),
          ),
          GestureDetector(
            onTap: (){
              makePayment('2000');
            },
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Color(0xFFE9E2E2))),
              child: Text("\$2000", style: AppWidget.SemiboldTextFeildStyle(),),
            ),
          ),
        ],
        ),
        SizedBox(height: 50,),
        GestureDetector(
          onTap: (){
            openEdit();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            width: MediaQuery.of(context).size.width/1.3,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF008080)),
            child: Center(child: Text("Add Money", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),),
          ),
        )
      ],),
      ),
    );
  }

  Future<void> makePayment(String amount)async{
    try{
      paymentIntent=await createPaymentIntent(amount, 'INR');
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Adnan'
      )).then((value) {});
      displayPaymentSheet(amount);
    }catch(e,s){
      print('exception: $e$s');
    }
  }

  displayPaymentSheet(String amount) async {

    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet().then((value) async{
        add=int.parse(wallet!)+int.parse(amount);
        await SharedPreferenceHelper().savedUserWallet(add.toString());
        await DatabaseMethods().UpdateUserWallet(id!, add.toString());
        showDialog(context: context, builder: (_)=> AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min, // Réduit la largeur du Row au minimum requis
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 15,),
              Text("Payment Successful")
            ],
          ),
        ));
        //wallet=SharedPreferenceHelper().getUserWallet() as String?;
        await getthesharedpref();
        paymentIntent=null;
      }).onError((error, stackTrace){
        print('Error is:---> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(context: context, builder: (_)=>const AlertDialog(
        content: Text("Cancelled"),
      ));
    }catch(e){
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency)async{
    final stripeSecretKey = dotenv.env['STRIPE_SECRET_KEY']!;
    try{
      Map<String, dynamic> body={
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]':'card',
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          //Stripe.publishableKey= dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
          //'Authorization':'Bearer $secretKey',
          'Authorization':'Bearer $stripeSecretKey',
          'Content-Type':'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    }catch(err){
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount){
    final calculateAmount=(int.parse(amount)*100);

    return calculateAmount.toString();
  }

  Future openEdit()=> showDialog(context: context, builder: (context)=>AlertDialog(
    content: SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel),
              ),
              SizedBox(width: 60,),
              Center(
                child: Text("Add Money", style: TextStyle(color: Color(0xFF008080), fontWeight: FontWeight.bold),),
              ),
            ]
          ),
          SizedBox(height: 20.0,),
          Text("Amount"),
          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 2),
                borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: amountcontroller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Amount',
              )
            ),
          ),
          SizedBox(height: 13.0,),
          GestureDetector(
            onTap: (){
              makePayment(amountcontroller.text);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF008080)),
              child: Text("Pay", style: TextStyle(fontSize: 15, fontFamily: "Poppins", )),
            ),
          )
          ],),
      )
    )
  ));

}

    

import 'package:ecommerce/pages/home.dart';
import 'package:ecommerce/pages/order.dart';
import 'package:ecommerce/pages/profile.dart';
import 'package:ecommerce/pages/wallet.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int currentTabIndex=0;

  // to naviagte to any page
  late List<Widget> pages;
  late Widget currentpage;
  late Home homepage;
  late Profile profile;
  late Order order;
  late Wallet wallet;

  @override
  void initState() {
    // TODO: implement initState
    homepage = Home();
    profile = Profile();
    order = Order();
    wallet = Wallet();
    pages = [homepage, order, wallet, profile];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
      height: 65,
      backgroundColor: Colors.white,
      color: Colors.black,
      animationDuration: Duration(milliseconds: 50),
      onTap:(int index){
        setState(() {
          currentTabIndex = index;
        });
      },
      items:
      [Icon(Icons.home_outlined, color: Colors.white,),
      Icon(Icons.shopping_cart_outlined, color: Colors.white,),
      Icon(Icons.wallet_giftcard, color: Colors.white),
      Icon(Icons.person_outlined, color: Colors.white,),
      ]),
      body: pages[currentTabIndex],
    );
  }
}

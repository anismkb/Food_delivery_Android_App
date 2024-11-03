import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods{
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id)async{
    return await FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .set(userInfoMap);
  }

  UpdateUserWallet(String id, String amount)async{
    return await FirebaseFirestore.instance.
    collection("users").doc(id).update({"wallet":amount});
  }

  Future addFoodItem(Map<String, dynamic> userInfoMap, String name)async{
    return await FirebaseFirestore.instance
        .collection(name)
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodItem(String name)async{
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addFoodToCart(Map<String, dynamic> AddfoodToCart, String id)async{
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('cart')
        .add(AddfoodToCart);
  }


  Future AddOrUpdateFoodInCart(Map<String, dynamic> AddfoodToCart, String id)async {
    var CarteCollection = FirebaseFirestore.instance.collection('users')
        .doc(id)
        .collection('cart');

    try{
      QuerySnapshot querySnapshot = await CarteCollection.where(
          "Name", isEqualTo: AddfoodToCart["Name"]).get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentId = querySnapshot.docs.first.id;
        return await CarteCollection.doc(documentId).update(
            {"Quantity": AddfoodToCart["Quantity"], "Total": AddfoodToCart["Total"]});
      }else{
        return await FirebaseFirestore.instance.collection('users')
            .doc(id)
            .collection('cart')
            .add(AddfoodToCart);
      }
    }catch(e){
      return await FirebaseFirestore.instance.collection('users')
          .doc(id)
          .collection('cart')
          .add(AddfoodToCart);
    }
  }

  Future<String?> getQuantity(String name, String id)async{
    var CartCollect =await FirebaseFirestore.instance.collection("users").doc(id).collection("cart");

    try{
      QuerySnapshot querySnapshot = await CartCollect.where("Name", isEqualTo: name).get();
      if(querySnapshot.docs.isNotEmpty){
        return querySnapshot.docs.first.get("Quantity");
      }else{
        return "0";
      }
    }catch(e){
      print("Erreur lors de l'accès à la collection cart : $e");
      return null;
    }
  }

  Future<String> getOrSetTotal(String Name, String Id)async{
    var CartCollect = await FirebaseFirestore.instance.collection("users").doc(Id).collection("cart");
    try{
      QuerySnapshot querySnapshot = await CartCollect.where("Name", isEqualTo: Name).get();
      if(querySnapshot.docs.isNotEmpty){
        return querySnapshot.docs.first.get("Total");
      }else{
        return "0";
      }
    }catch(e){
      return "0";
    }

  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id)async{
    return await FirebaseFirestore.instance.collection("users").doc(id).collection("cart").snapshots();
  }



}
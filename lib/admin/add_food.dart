import 'dart:io';

import 'package:ecommerce/admin/admin_home.dart';
import 'package:ecommerce/admin/admin_login.dart';
import 'package:ecommerce/service/database.dart';
import 'package:ecommerce/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {

  final List<String>items=["Ic-cream", "Burger", "Salad", "Pizza"];
  String? value;
  TextEditingController namecontroller= new TextEditingController();
  TextEditingController pricecontroller= new TextEditingController();
  TextEditingController detailscontroller= new TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage()async{
    var image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage= File(image!.path);
    });
  }

  LoadItem() async{
    if(selectedImage!=null && namecontroller!="" && detailscontroller!="" && pricecontroller!=""){
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("BlogImage").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var DownloadUrl = await(await task).ref.getDownloadURL();

      Map<String, dynamic> addItem={
        "Image":DownloadUrl,
        "nam":namecontroller.text,
        "price":pricecontroller.text,
        "details":detailscontroller.text,
      };
      await DatabaseMethods().addFoodItem(addItem, value!).then((value){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text(
            "The Item has been added succefuly",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      });
    }
  }

  //fonction pour récupérer les données perdu
  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) return;

    if (response.file != null) {
      setState(() {
        selectedImage = response.file as File?; // Récupère l'image si elle a été perdue
      });
    } else {
      print('Aucune image récupérée');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveLostData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Admin_Home()));
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text("Add item",
        style:AppWidget.HeadLineTextFeildStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Upload the item picture",style: AppWidget.boldTextFeildStyle(),),
          SizedBox(height: 20,),
          selectedImage==null?GestureDetector(
            onTap: (){
              getImage();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                    child: Center(
                      child: Icon(Icons.camera_alt_outlined, size: 30, color: Colors.black,),
                    ),
                  ),
                )
              ],
            ),
          ):Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: Colors.black,
                          width: 2
                      )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Center(
                      child: Image.file(selectedImage as File, fit:BoxFit.cover),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 30,),
          Text("Item name",style: AppWidget.boldTextFeildStyle(),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFFececf8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: namecontroller,
              validator: (value){
                if(value==null || value.isEmpty){
                  return "Enter a name for the item";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter an item name",
                border: InputBorder.none,
                hintStyle: AppWidget.LightTextFeildStyle(),
              ),
        
            ),
          ),
          SizedBox(height: 30,),
          Text("Item Price",style: AppWidget.boldTextFeildStyle(),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFFececf8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: pricecontroller,
              validator: (value){
                if(value==null || value.isEmpty){
                  return "Enter a price for the item";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter the price",
                border: InputBorder.none,
                hintStyle: AppWidget.LightTextFeildStyle(),
              ),
            ),
          ),
          SizedBox(height: 30,),
          Text("Item Details",style: AppWidget.boldTextFeildStyle(),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFFececf8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: detailscontroller,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "Enter the détails",
                border: InputBorder.none,
                hintStyle: AppWidget.LightTextFeildStyle(),
              ),
            ),
          ),
          SizedBox(height: 30,),
          Text("Select Category",style: AppWidget.boldTextFeildStyle(),),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFececf8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(child: DropdownButton<String>(items: items.map((item)=>DropdownMenuItem<String>(
              value:item,
              child: Text(item, style: TextStyle(fontSize: 18, color: Colors.black),))).toList(),
              onChanged: ((value)=>setState(() {
                this.value=value;
              })),
              dropdownColor: Colors.white, hint: Text("Select Category"),
              iconSize: 36, icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              value: value,) )
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              LoadItem();
            },
            child: Center(
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Center(child: Text("Add", style: TextStyle(fontSize: 25, fontFamily: "Pippins", color: Colors.white, fontWeight: FontWeight.bold),))
                ),
              ),
            ),
          )
          ],
        ),),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/pages/cart.dart';
import 'package:shoppingapp/pages/electronics.dart';
import 'package:shoppingapp/pages/favourites.dart';
import 'package:shoppingapp/pages/jeweller.dart';
import 'package:shoppingapp/pages/mens_clothing.dart';
import 'package:shoppingapp/pages/profile.dart';
import 'package:shoppingapp/pages/signup.dart';
import 'package:shoppingapp/pages/women.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {

    
CollectionReference user_collection = FirebaseFirestore.instance.collection('Users');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Cart()));
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.black,
                              )),
                        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(child: Text('SwiftCart',style: TextStyle(fontSize: 40,color: Colors.black),)),
            ),
            ListTile(
              title: const Text('Profile'),
              leading: Icon(Icons.person),
              onTap: () {
                // Update the state of the app.
                // ...
                
                    setState(() {
                      Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
                    });
              },
            ),

            ListTile(
              title: Text('Favourites'),
              leading: Icon(Icons.thumb_up_sharp),
              onTap: () {
                // Update the state of the app.
                // ...
                
                    setState(() {
                      Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Fav()));
                    });
              },
            ),

            ListTile(
              title: const Text('Cart'),
              leading: Icon(Icons.shopping_cart),
              onTap: () {
                // Update the state of the app.
                // ...
                
                setState(() {
                      Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Cart()));
                    });
              },
            ),
            ListTile(
              title: const Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () async {
                // Update the state of the app.
                // ...
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Log()));
              },
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          
          children: [
            SizedBox(height: height*0.02,),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              InkWell(
                onTap: (){
      
                  setState(() {
               
               Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Men()));
      
                });
                },
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                    height: height*0.30,
                    width: width*0.35,
                    
                    
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue[100]),
                    child: Center(
                      child: Column(children: [
                      Hero(tag:'men',child: Image.asset('assets/tshirt.png',height: height*0.20,width: width*0.30,)),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8,0, 8,8),
                        child: Container(width:width*0.2,child: Center(child: Text('Men\'s fashion',textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),)))
                                  
                                  ],),
                    ),
                  ),
                ),
              ),
      
                 InkWell(
                   onTap: (){
      
                     setState(() {
                  
                  Navigator.push(
                     context, MaterialPageRoute(builder: (context) => WomenClothes()));
      
                   });
                   },
                   child: Container(
                    height: height*0.30,
                    width: width*0.35,
                     
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue[100]),
                     child: Center(
                       child: Column(children: [
                       Hero(tag:'women',child: Image.asset('assets/dress.png',height:height*0.20,width: width*0.30,)),
                       Padding(
                         padding: EdgeInsets.fromLTRB(8,0, 8,8),
                         child: Container(width:width*0.2,child: Center(child: Text('Women\'s fashion',textAlign: TextAlign.center,style: TextStyle(fontSize: 16),))))
                                   
                                   ],),
                     ),
                   ),
                 ),
      
                
              // OutlinedButton.icon(onPressed: (){
              //  setState(() {
                 
              //    Navigator.push(
              //       context, MaterialPageRoute(builder: (context) => Men()));
              //  }); 
              // }, icon: Icon(Icons.person), label: Text('Men')),
              // OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.person), label: Text('Jewellery')),
              // OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.person), label: Text('Women')),
              // OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.person), label: Text('Electronics'))
            ]
          ),
          SizedBox(height: height*0.03,),
          Center(child: Text('SwiftCart',style: TextStyle(fontSize: 40,fontFamily: 'Schyler'),)),
          SizedBox(height: height*0.03,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            


             InkWell(
                   onTap: (){
      
                     setState(() {
                  
                  Navigator.push(
                     context, MaterialPageRoute(builder: (context) => jewel()));
      
                   });
                   },
                   child: Padding(
                     padding: EdgeInsets.all(2),
                  
                     child: Container(
                      height: height*0.30,
                    width: width*0.35,
                       
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue[100]),
                       child: Center(
                         child: Column(children: [
                         Hero(tag:'jewel',child: Image.asset('assets/earrings.png',height: height*0.20,width: width*0.30,)),
                         Padding(
                           padding: EdgeInsets.fromLTRB(8,0, 8,8),
                           child: Container(width:width*0.2,child: Center(child: Text('Jewellery',textAlign: TextAlign.center,style: TextStyle(fontSize: 16),))))
                                     
                                     ],),
                       ),
                     ),
                   ),
                 ),
      
                 InkWell(
                   onTap: (){
      
                     setState(() {
                  
                  Navigator.push(
                     context, MaterialPageRoute(builder: (context) => electronics()));
      
                   });
                   },
                   child: Container(
                  height: height*0.30,
                    width: width*0.35,
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue[100]),
                     child: Center(
                       child: Column(children: [
                       Hero(tag:'electro',child: Image.asset('assets/device.png',height: height*0.20,width: width*0.30,)),
                       Padding(
                         padding: EdgeInsets.fromLTRB(8,0, 8,8),
                         child: Container(width: width*0.2,child: Center(child: Text('Electronics',textAlign: TextAlign.center,style: TextStyle(fontSize: 14),))))
                                   
                                   ],),
                     ),
                   ),
                 ),

          ],)

          
          ]
        ),
      ),
    );
  }
}

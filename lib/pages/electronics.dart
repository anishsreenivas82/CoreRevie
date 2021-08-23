import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppingapp/pages/cart.dart'; 

CollectionReference user_collection = FirebaseFirestore.instance.collection('Users');

List dataelec = [];
Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

class electronics extends StatefulWidget {
  @override
  _electronicsState createState() => _electronicsState();
}

class _electronicsState extends State<electronics> {
  void getProduct() async {
    Response response =
        await get(Uri.parse('https://fakestoreapi.com/products'));
    List data = jsonDecode(response.body);
    for (int i = 8; i <= 13; i++) {
      dataelec.add(data[i]);
    }
    print(dataelec);
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: wait(3),
        builder: (context, snapshot){
          if(dataelec.length.toString() != '0'){
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.green[50],
               
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        backgroundColor: Colors.blue,
                        pinned: true,
                        snap: true,
                        floating: true,
                        expandedHeight: height * 0.4,
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
                                color: Color(0xffd4fff7),
                              ))
                        ],
                             flexibleSpace: new FlexibleSpaceBar(
                            title: Text(
                              "SwiftCart",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Satisfy',
                                color: Colors.grey[100],
                                fontSize: 40,
                              ),
                            ),
                            centerTitle: true,
                           background: Hero(tag:'electro',child: Image.asset('assets/device.png',height:height*0.3,width: width*0.8,)),
                      ),
                      ),
                    ];
                  },
                  body: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: EdgeInsets.all(height * 0.007),
                          child: Card(
                            elevation: height * 0.005,
                            child: Container(
                                height: height * 0.35,
                                width: width * 0.87,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                          height: height * 0.3,
                                          width: width * 0.41,
                                          decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: NetworkImage(
                                                  dataelec[index]["image"]),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.05,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: height * 0.1,
                                            width: width * 0.30,
                                            child: Text(
                                              dataelec[index]["title"],
                                              style: TextStyle(
                                                  fontFamily: 'STIXTwoText',
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.025,
                                          ),
                                          Center(
                                            child: Container(
                                              height: height * 0.025,
                                              width: width * 0.30,
                                              child: Text(
                                                '\$ ' +
                                                    dataelec[index]["price"]
                                                        .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'STIXTwoText',
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.05,
                                          ),
                                          Center(
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      int id= dataelec[index]["id"];
                                                    final user = FirebaseAuth.instance.currentUser!;
                                                    var UID = user.uid;
                                                     user_collection
                                                    .doc(UID).collection('Cart').
                                                    doc(id.toString())
                                                    .set({
                                                      'Category':dataelec[index]["category"],
                                                      'Price':dataelec[index]["price"],
                                                      'Name': dataelec[index]["title"],
                                                      'Image': dataelec[index]["image"],        
                                                      });
                                                      Fluttertoast.showToast(
                                                    msg: "Added To Cart",
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Color(0xff7beed9),
                                                    textColor: Colors.black,
                                                    fontSize: 16.0);
                                                    },
                                                    icon: Icon(
                                                      Icons.add_shopping_cart,
                                                      color: Colors.black,
                                                    )),
                                                SizedBox(
                                                  width: width * 0.001,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                       int id= dataelec[index]["id"];
                                                    final user = FirebaseAuth.instance.currentUser!;
                                                    var UID = user.uid;
                                                     user_collection
                                                    .doc(UID).collection('Favourites').
                                                    doc(id.toString())
                                                    .set({
                                                      'Category':dataelec[index]["category"],
                                                      'Price':dataelec[index]["price"],
                                                      'Name': dataelec[index]["title"],
                                                      'Image': dataelec[index]["image"],        
                                                      });
                                                      Fluttertoast.showToast(
                                                    msg: "Added To Favourites",
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Color(0xff7beed9),
                                                    textColor: Colors.black,
                                                    fontSize: 16.0);
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .favorite_outline_sharp,
                                                      color: Colors.black,
                                                    )),
                                                // IconButton(
                                                //     onPressed: () {

                                                //        int id= dataelec[index]["id"];
                                                //     final user = FirebaseAuth.instance.currentUser!;
                                                //     var UID = user.uid;
                                                //      user_collection
                                                //     .doc(UID).collection('Favourites').
                                                //     doc(id.toString())
                                                //     .set({
                                                //       'Category':dataelec[index]["category"],
                                                //       'Price':dataelec[index]["price"],
                                                //       'Title': dataelec[index]["title"],
                                                //       'Image': dataelec[index]["image"],        
                                                //       });
                                                //       Fluttertoast.showToast(
                                                //     msg: "Added To Favourites",
                                                //     toastLength: Toast.LENGTH_LONG,
                                                //     gravity: ToastGravity.BOTTOM,
                                                //     timeInSecForIosWeb: 1,
                                                //     backgroundColor: Color(0xff7beed9),
                                                //     textColor: Colors.black,
                                                //     fontSize: 16.0);
                                                //     },
                                                //     icon: Icon(
                                                //       Icons
                                                //           .thumb_up_sharp,
                                                //       color: Colors.black,
                                                //     )),

                                                    // IconButton(onPressed: (){}, icon: Icon(
                                                    //   Icons.next_plan,
                                                    //   color: Colors.black,
                                                    // )),
                                                    
                                                    
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }),
                ),
              ),
            );
          }
          return Scaffold(body: Container(height:height*0.7,width: width,child: Center(child: Lottie.asset('assets/loading.json'))));
        });
  }
}
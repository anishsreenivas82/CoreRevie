

import 'dart:convert';
// import 'package:core/Nav_Bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart';
import 'package:shoppingapp/pages/cart.dart';
import 'package:shoppingapp/pages/favourites.dart';
CollectionReference user_collection = FirebaseFirestore.instance.collection('Users');

List men = [];
Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

class Men extends StatefulWidget {
  const Men({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

// final GoogleSignIn _googleSignIn = new GoogleSignIn();

class _HomeState extends State<Men> {
  void getProduct() async {
    Response response =
        await get(Uri.parse('https://fakestoreapi.com/products'));
    List data = jsonDecode(response.body);
    for (int i = 0; i <= 3; i++) {
      men.add(data[i]);
    }
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: wait(3),
        builder: (context, snapshot) {
          if (men.length.toString() != '0') {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.green[50],
                // drawer: NavBar(),
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
                                      builder: (context) => Fav()));
                            },
                            icon: Icon(
                              Icons.thumb_up_sharp,
                              color: Colors.black,
                            )),
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
                        flexibleSpace: new FlexibleSpaceBar(
                            title: Text(
                              "SwiftCart",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Satisfy',
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                            centerTitle: true,
                           background: Hero(tag:'men',child: Image.asset('assets/tshirt.png',height:height*0.3,width: width*0.8,)),
                      ),
                      )];
                  },
                  body: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: EdgeInsets.all(height * 0.004),
                          child: Card(
                            elevation: height * 0.005,
                            child: Container(
                                height: height * 0.35,
                                width: width * 0.7,
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
                                                  men[index]["image"]),
                                              fit: BoxFit.cover,
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
                                              men[index]["title"],
                                              style: TextStyle(
                                                  fontFamily: 'STIXTwoText',
                                                  color: Colors.black,
                                                  fontSize: 15,
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
                                                    men[index]["price"]
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
                                                      var uid = FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid;
                                                      FirebaseFirestore.instance
                                                          .collection('Users')
                                                          .doc(uid)
                                                          .collection('Cart')
                                                          .doc(men[index]['id'].toString())
                                                          .set({
                                                        'Name': men[index]
                                                            ['title'],

                                                          'Price':men[index]['price'],
                                                          'Image':men[index]['image'],



                                                      });

                                                      Fluttertoast.showToast(
                              msg: "Added To Cart",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
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

                                                      int id= men[index]["id"];
                                                    final user = FirebaseAuth.instance.currentUser!;
                                                    var uid = user.uid;
                                                     user_collection
                                                    .doc(uid).collection('Favourites').
                                                    doc(id.toString())
                                                    .set({
                                                      'Category':men[index]["category"],
                                                      'Price':men[index]["price"],
                                                      'Name': men[index]["title"],
                                                      'Image': men[index]["image"],        
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
                                                          .thumb_up_sharp,
                                                      color: Colors.black,
                                                    )),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.next_plan,
                                                      color: Colors.black,
                                                    )),
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
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }
}

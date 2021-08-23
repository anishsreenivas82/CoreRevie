import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/Dashboard.dart';
import 'package:shoppingapp/pages/cart.dart';

double sum = 0;

class Fav extends StatefulWidget {
  const Fav({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Fav> {
  // Future<double> total(double i) async {
  //      var uid = FirebaseAuth.instance.currentUser!.uid;

  //      i = 0;
  //     FirebaseFirestore.instance.collection('Users').doc(uid).collection('Cart').get().then((querySnapshot){
  //       querySnapshot.docs.forEach((document) {

  //         setState(() {
  //           i = i + document.get('Name');
  //         });
  //        });
  //     });

  //     print(i);

  //     return i;

  //   }
  // @override
  // void initState() {

  // super.initState();
  //    var uid = FirebaseAuth.instance.currentUser!.uid;
  //  FirebaseFirestore.instance.collection('Users').doc(uid).collection('Total').doc('Total').get().then((DocumentSnapshot snap){

  //     if (snap.exists) {

  //   double i = 0;

  //        FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(uid)
  //       .collection('Cart')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       i = i + doc['Price'];
  //     });
  //     FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(uid)
  //         .collection('Total')
  //         .doc('Total')
  //         .set({'Total Price': i});
  //   });

  //     setState(() {
  //       sum = snap['Total Price'];
  //     });

  //     }

  //   });

  //   }

  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser!.uid;

    // double i = 0;

    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(uid)
    //     .collection('Cart')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     i = i + doc['Price'];
    //   });
    //   FirebaseFirestore.instance
    //       .collection('Users')
    //       .doc(uid)
    //       .collection('Total')
    //       .doc('Total')
    //       .set({'Total Price': i});
    // });

    // setState(() {
    //   total(sum);
    // });

    // double x = 0;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // CollectionReference user_collection = FirebaseFirestore.instance.collection('Users');

    final Stream<QuerySnapshot> fav_items = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Favourites')
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
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
        title: Text('Favourites'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fav_items,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if (snapshot.hasData) {
            return new ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                // sum = sum + data['Price'];
                // FirebaseFirestore.instance.collection('Users').doc(uid).collection('Total').doc('Total').set({'Total Price':sum});

                return Padding(
                  padding: EdgeInsets.fromLTRB(width*0.001,height*0.02, width*0.001, 0),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      height: height * 0.30,
                      width: width,
                      child: Row(
                        children: [
                          Image.network(data['Image'],
                              height: height * 0.3, width: width * 0.4),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: width * 0.55,
                                  child: Center(child: Text(data['Name']))),
                              Wrap(children: [Text('\$'+data['Price'].toString(),style: TextStyle(fontSize: 18),)]),
                              Row(children: [
                                IconButton(
                                    onPressed: () {
                                      var docId = document.id;
                                      print(docId);
                                  
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(uid)
                                          .collection('Favourites')
                                          .doc(docId)
                                          .delete();
                                  
                                      setState(() {
                                        sum = sum - data['Price'];
                                      });
                                    },
                                    icon: Icon(Icons.delete)),
                                IconButton(
                                    onPressed: () {
                                      var docId = document.id;
                                      print(docId);
                                  
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(uid)
                                          .collection('Cart')
                                          .doc(docId)
                                          .set({
                                        'Name': data['Name'],
                                        'Price': data['Price'],
                                        'Image': data['Image']
                                      });
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(uid)
                                          .collection('Favourites')
                                          .doc(docId)
                                          .delete();
                                    },
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  width: width * 0.001,
                                ),
                              ])
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
          return Center(child: Text('No Items in cart'));
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Container(
      //     height: height * 0.1,
      //     width: width,
      //     color: Colors.green[50],
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         TextButton(onPressed: () {

      //           Navigator.push(
      //             context, MaterialPageRoute(builder: (context) => Dashboard()));
      //         }, child: Text('Add More')),
      //         Container(

      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text('Place Order',style: TextStyle(color: Colors.blue),),
      //             Text('Total:\$$sum',style: TextStyle(color: Colors.green[400]),),
      //           ],
      //         ))
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/pages/signup.dart';

String name = '';
String ph = '';
String email_id = '';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  
  @override
  Widget build(BuildContext context) {
    
    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(uid)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
        
    //   }
    // });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(

      
      future: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        name = snapshot.data!['Name'];
        ph = snapshot.data!['Phone Number'];
        email_id = snapshot.data!['Email'];
        return SafeArea(
        child: Scaffold(

          appBar: AppBar(
            title: Text('Profile'),
            centerTitle: true,
          ),
         
          backgroundColor: Colors.green[50],
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Icon(Icons.person, size: height * 0.4),
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: height*0.05,),
                  // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  //   Icon(
                  //     Icons.phone,
                  //     size: 25,
                      
                  //   ),
                  //   SizedBox(
                  //     width: width * 0.2,
                  //   ),
                  //   Text(
                  //     ph,
                  //     style: TextStyle(fontSize: 25),
                  //   )
                  // ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Column(
                      children: 
                        [Icon(
                          Icons.email,
                          size: 25,
                        ),
                        SizedBox(height: height*0.05,),
                        Icon(
                      Icons.phone,
                      size: 25,
                      
                    ),
                      ],
                    ),
                    SizedBox(
                      width: width * 0.2,
                    ),
                    Column(
                      children: 
                        [Wrap(
                          children: 
                            [Text(
                              email_id,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: height*0.05,),
                        Wrap(
                          children: 
                          [Text(
                                            ph,
                                            style: TextStyle(fontSize: 20),
                                            
                          ),
                        ],
                    )
                  ]),
                ],
              
                    ),
                    SizedBox(height: height*0.05,),
            
                    // OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.black,), label: Text('Edit',style: TextStyle(color: Colors.black),))
                ],
                ),
            ))));}

            return Scaffold(body: CircularProgressIndicator(),);
      });
  }
}

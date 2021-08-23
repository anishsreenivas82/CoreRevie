import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppingapp/Dashboard.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Log extends StatefulWidget {
  const Log({ Key? key }) : super(key: key);

  @override
  _LogState createState() => _LogState();
}

class _LogState extends State<Log> {

  Future<void> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
   await FirebaseAuth.instance.signInWithCredential(credential);

   final user = FirebaseAuth.instance.currentUser!;
                        var  UID = user.uid;
                        var name = user.displayName;
                       var email_id = user.email;
                       var phone = user.phoneNumber;
                        var   photo = user.photoURL.toString();
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(UID)
                              .set({
                                'Name':name,
                                'Email':email_id,
                                'Image':photo,
                                'Phone Number':phone

                              });

   
   
}

  final email = TextEditingController();
  final pass = TextEditingController();
  final semail = TextEditingController();
  final spass = TextEditingController();
  final sname = TextEditingController();
  final snum = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return MaterialApp(
      home: DefaultTabController(length: 2,
      child: Scaffold(appBar: 
      AppBar(
       
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.login),
                  text: 'Login',
                ),
                Tab(icon: Icon(Icons.person), text: 'Sign Up'),
              ],
      ),
       title: Text('Login'),
            centerTitle: true,),
            backgroundColor: Colors.green[50],
            
            body: TabBarView(children: [
              ListView(children: [
                Container(
                      padding: EdgeInsets.fromLTRB(0,0,MediaQuery.of(context).size.width*0.08,0),
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width*0.8,
                      child: Hero(child: Lottie.asset('assets/shoppingcart.json',repeat: true),tag: 'lottie_anim',),
                    ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 8, 6, 10),
                  child: TextFormField(
                    controller: email ,
                    decoration: InputDecoration(hintText:'Email',fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,width: 2)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.brown,width: 2)))
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(6, 0, 6, 8),
                   child: TextFormField(
                     obscureText: true,
                    controller: pass,
                    decoration: InputDecoration(hintText:'Password',fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,width: 2)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.brown,width: 2)))
                ),
                 ),
                TextButton.icon(
                  
                        onPressed: () async {
                          try {
                            UserCredential userCredential =
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email.text,
                                        password: pass.text);

                                        

                              Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              Fluttertoast.showToast(
                              msg: "No user found for that email.",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print(
                                  'Wrong password provided for that user.');
                                   Fluttertoast.showToast(
                              msg: "Wrong password provided for that user.",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                            }
                          }
                        },
                        icon: Icon(Icons.navigate_next_outlined),
                        label: Text('Sign In',
                            style: TextStyle(
                                fontSize: 24,
                                
                                ))),

                                TextButton.icon(onPressed: (){

                                  signInWithGoogle();
                                }, icon: Icon(Icons.report_gmailerrorred), label: Text('Sign In With Google'))
              ],),

               ListView(children: [
                 Container(
                      padding: EdgeInsets.fromLTRB(0,0,MediaQuery.of(context).size.width*0.08,0),
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width*0.8,
                      child: Hero(child: Lottie.asset('assets/shoppingcart.json',repeat: true),tag: 'lottie_anim',),
                    ),
                   
                    Padding(
                      padding:  EdgeInsets.fromLTRB(width*0.02, height*0.05, width*0.02, height*0.03),
                      child: TextFormField(
                  controller:sname,
                  decoration: InputDecoration(hintText:'Name',fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,width: 2)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.brown,width: 2)))
                ),
                    ),
                
                Padding(
                  padding:  EdgeInsets.fromLTRB(width*0.02, 0, width*0.02, height*0.03),
                  child: TextFormField(
                    controller:snum,
                    decoration: InputDecoration(hintText:'Phone Number',fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,width: 2)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.brown,width: 2)))
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(width*0.02, 0, width*0.02, height*0.03),
                  child: TextFormField(
                    controller: semail ,
                    decoration: InputDecoration(hintText:'Email',fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,width: 2)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.brown,width: 2)))
                  ),
                ),
                 Padding(
                   padding:  EdgeInsets.fromLTRB(width*0.02, 0, width*0.02, height*0.03),
                   child: TextFormField(
                    controller:spass,
                    obscureText: true,
                    decoration: InputDecoration(hintText:'Password',fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,width: 2)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.brown,width: 2)))
                ),
                 ),
                 TextButton.icon(
                        onPressed: () async {
                          try {
                            UserCredential userCredential =
                                await FirebaseAuth.instance 
                                    .createUserWithEmailAndPassword(
                              email: semail.text,
                              password: spass.text,);
                               var uid = FirebaseAuth.instance.currentUser!.uid;
                               FirebaseFirestore.instance.collection('Users').doc(uid).set({
                                 'Email': semail.text,
                            'Password': spass.text,
                            'Name':sname.text,
                            'Phone Number': snum.text
                            
                               });
                               Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard()));
                            
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                               Fluttertoast.showToast(
                              msg: "The password provided is too weak.",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              fontSize: 16.0);
                            
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                                  Fluttertoast.showToast(
                              msg:
                                  "The account already exists for that email.",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              fontSize: 16.0);
                            }
                          } catch (e) {
                            print(e);
                             Fluttertoast.showToast(
                            msg: "$e",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: Colors.red,
                            fontSize: 16.0);
                          }
                        },
                        label: Text('Sign Up',
                            style: TextStyle(
                                fontSize: 24,
                                
                                )),
                                icon: Icon(Icons.check_box),
                                  )
                
              ],)
            ],),),
      
    ));
  }
}
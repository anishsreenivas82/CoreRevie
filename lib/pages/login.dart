// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shoppingapp/Dashboard.dart';

// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);

//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {

  
//   @override
//   Widget build(BuildContext context) {
//     final emailcontroller = TextEditingController();
//     TextEditingController passwordcontroller = new TextEditingController();
//     TextEditingController semail = new TextEditingController();
//     TextEditingController spass = new TextEditingController();
//     // TextEditingController phno = new TextEditingController();
//     // TextEditingController location = new TextEditingController();

//     return MaterialApp(
//       home: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           backgroundColor: Colors.amber[100],
//           appBar: AppBar(
//             backgroundColor: Colors.black,
//             bottom: TabBar(
//               tabs: [
//                 Tab(
//                   icon: Icon(Icons.login),
//                   text: 'Login',
//                 ),
//                 Tab(icon: Icon(Icons.person), text: 'Sign Up'),
//               ],
//             ),
//             title: Text('Login'),
//             centerTitle: true,
//           ),
//           body: TabBarView(children: [
//             ListView(
//                 // mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Column(children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(0,0,MediaQuery.of(context).size.width*0.08,0),
//                       height: MediaQuery.of(context).size.height*0.3,
//                       width: MediaQuery.of(context).size.width*0.8,
//                       child: Hero(child: Lottie.asset('assets/shoppingcart.json',repeat: true),tag: 'lottie_anim',),
//                     ),
//                     // _textInput(
//                     //     hint: "Email",
//                     //     icon: Icons.person,
//                     //     myController: emailcontroller,
//                     //     obscure: false),

//                     TextFormField(
//                       controller: emailcontroller,
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Email'
//                       ),
//                     ),
//                     _textInput(
//                         hint: "Password",
//                         icon: Icons.lock,
//                         myController: passwordcontroller,
//                         obscure: true),
//                     TextButton(
//                         onPressed: () async {
//                           try {
//                             UserCredential userCredential =
//                                 await FirebaseAuth.instance
//                                     .signInWithEmailAndPassword(
//                                         email: emailcontroller.text,
//                                         password: passwordcontroller.text);

//                               // Navigator.push(
//                               //       context, 
//                               //       MaterialPageRoute(
//                               //           builder: (context) => Dashboard()));
//                           } on FirebaseAuthException catch (e) {
//                             if (e.code == 'user-not-found') {
//                               Fluttertoast.showToast(
//                               msg: "No user found for that email.",
//                               toastLength: Toast.LENGTH_LONG,
//                               gravity: ToastGravity.BOTTOM,
//                               timeInSecForIosWeb: 1,
//                               backgroundColor: Colors.red,
//                               textColor: Colors.white,
//                               fontSize: 16.0);
//                               print('No user found for that email.');
//                             } else if (e.code == 'wrong-password') {
//                               print(
//                                   'Wrong password provided for that user.');
//                                    Fluttertoast.showToast(
//                               msg: "Wrong password provided for that user.",
//                               toastLength: Toast.LENGTH_LONG,
//                               gravity: ToastGravity.BOTTOM,
//                               timeInSecForIosWeb: 1,
//                               backgroundColor: Colors.red,
//                               textColor: Colors.white,
//                               fontSize: 16.0);
//                             }
//                           }
//                         },
//                         child: Text('Sign In',
//                             style: TextStyle(
//                                 fontSize: 24,
//                                 background: Paint()..color,
//                                 color: Colors.amber[100])))
//                   ])
//                 ]),
//             ListView(children: <Widget>[
//               Column(
//                   // mainAxisSize: MainAxisSize.max,
                  
//                   children: <Widget>[

//                     Container(
//                       height: MediaQuery.of(context).size.height*0.3,
//                       width: MediaQuery.of(context).size.width*0.8,
//                        padding: EdgeInsets.fromLTRB(0,0,MediaQuery.of(context).size.width*0.08,0),
//                       child: Hero(child: Lottie.asset('assets/shoppingcart.json',repeat: true,),tag: 'lottie_anim'),
//                     ),
//                     _textInput(
//                         hint: "Email",
//                         icon: Icons.person,
//                         myController: semail,
//                         obscure: false),
//                     _textInput(
//                         hint: "Password",
//                         icon: Icons.lock,
//                         myController: spass,
//                         obscure: true),
//                     TextButton(
//                         onPressed: () async {
//                           try {
//                             UserCredential userCredential =
//                                 await FirebaseAuth.instance 
//                                     .createUserWithEmailAndPassword(
//                               email: semail.text,
//                               password: spass.text,);
//                               // var uid = FirebaseAuth.instance.currentUser!.uid;
//                                FirebaseFirestore.instance.collection('Users').add({
//                                  'Email': semail.text,
//                             'Password': spass.text,
                            
//                                });
                            
//                           } on FirebaseAuthException catch (e) {
//                             if (e.code == 'weak-password') {
//                               print('The password provided is too weak.');
//                                Fluttertoast.showToast(
//                               msg: "The password provided is too weak.",
//                               toastLength: Toast.LENGTH_LONG,
//                               gravity: ToastGravity.CENTER,
//                               timeInSecForIosWeb: 1,
//                               backgroundColor: Colors.white,
//                               textColor: Colors.red,
//                               fontSize: 16.0);
                            
//                             } else if (e.code == 'email-already-in-use') {
//                               print(
//                                   'The account already exists for that email.');
//                                   Fluttertoast.showToast(
//                               msg:
//                                   "The account already exists for that email.",
//                               toastLength: Toast.LENGTH_LONG,
//                               gravity: ToastGravity.BOTTOM,
//                               timeInSecForIosWeb: 1,
//                               backgroundColor: Colors.white,
//                               textColor: Colors.red,
//                               fontSize: 16.0);
//                             }
//                           } catch (e) {
//                             print(e);
//                              Fluttertoast.showToast(
//                             msg: "$e",
//                             toastLength: Toast.LENGTH_LONG,
//                             gravity: ToastGravity.BOTTOM,
//                             timeInSecForIosWeb: 1,
//                             backgroundColor: Colors.white,
//                             textColor: Colors.red,
//                             fontSize: 16.0);
//                           }
//                         },
//                         child: Text('Sign Up',
//                             style: TextStyle(
//                                 fontSize: 24,
//                                 background: Paint()..color,
//                                 color: Colors.amber[100])))
//                   ])
//             ])
//           ]),
//         ),
//       ),
//     );
//   }
// }

// Widget _textInput({hint, icon, myController, obscure}) {
//   return Container(
//     margin: EdgeInsets.only(top: 10),
//     padding: EdgeInsets.only(left: 10),
//     child: TextField(
//       controller: myController,
//       decoration: InputDecoration(
//         border: new UnderlineInputBorder(
//           borderSide: new BorderSide(),
//         ),
//         hintText: hint,
//         prefixIcon: Icon(icon),
//       ),
//       obscureText: obscure,
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppingapp/pages/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

//   try {
//   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: "barry.allen@example.com",
//     password: "SuperSecretPassword!"
//   );
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'weak-password') {
//     print('The password provided is too weak.');
//   } else if (e.code == 'email-already-in-use') {
//     print('The account already exists for that email.');
//   }
// } catch (e) {
//   print(e);
// }

final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: _initialization,
      builder: (context,snapshot){
        if (snapshot.hasError) {
          return Text('Error');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Anim();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(height:height*0.7,width: width,child: Center(child: Lottie.asset('assets/loading.json'),));
      }
      
    );
  }
}

// class Home extends StatefulWidget {
//   const Home({ Key? key }) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Anim();
//   }
// }

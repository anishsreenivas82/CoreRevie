// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppingapp/Dashboard.dart';
import 'package:shoppingapp/pages/login.dart';
import 'package:shoppingapp/pages/signup.dart';

// import 'package:flutter/src/widgets/framework.dart';

class Anim extends StatefulWidget {
  const Anim({Key? key}) : super(key: key);

  @override
  _AnimState createState() => _AnimState();
}

class _AnimState extends State<Anim> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
     
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width*0.1, 0),
                child: Container(
                  height: 0.6 * MediaQuery.of(context).size.height,
                  width: 0.9 * MediaQuery.of(context).size.width,
                  child: Hero(
                    tag: 'lottie_anim',
                    child: Lottie.asset('assets/shoppingcart.json',
                        controller: _controller, onLoaded: (composition) {
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() => FirebaseAuth.instance
                                .authStateChanges()
                                .listen((User? user) {
                              if (user == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Log()),
                                );
                              } else {
                                Navigator.push(
                                  context,  
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()),
                                );
                              }
                            }));
                    }),
                    
                  ),
                ),
              ),
              Center(
                  child: Text(
                'SwiftCart',
                style: TextStyle(fontSize: 30, color: Colors.brown[200]),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

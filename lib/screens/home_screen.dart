import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'emai_auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pop(context,(route)=> route.isFirst);

    Navigator.push(
      context, CupertinoPageRoute(builder: (context) => LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Home"),
            actions: [
              IconButton(
                onPressed: logout,
                icon: const Icon(Icons.logout),
              )
            ],
            backgroundColor: Colors.grey),
        body: Center(
          child: const Column(children: [
            Text("Home"),
          ]),
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/emai_auth/login_screen.dart';
import 'package:flutter_firebase/screens/emai_auth/signup_screen.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // TO FETCH DATA OF WHOLE COLLECTION
  // QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("users").get();
  // for (var doc in snapshot.docs) {
  //   print(doc.data().toString());
  // }

  // TO FETCH THE PERTICULAR DOCUMNET FROM FIRESTORE USING ID
  // DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("YypGaMRosLOHN2tMLipX")
  //     .get();

  // print(snapshot.data());

  // HOW TO WRITE IN FIRESTORE this method gives automatically ID to the document
  // Map<String, dynamic> newUserData = {
  //   "name" : "PRANS",
  //   "email" : "prans@gmail.com"
  // };
  // await FirebaseFirestore.instance.collection("users").add(newUserData);
  // print("New User Saved");

  // To manually give an id to document
  // Map<String, dynamic> newUserData = {
  //   "name": "kriss",
  //   "email": "kriss@gmail.com"
  // };
  // await FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("yPIYUsHuF6NqJGL10k9h")
  //     .set(newUserData);
  // print("New User Saved");


  //To update the data
  await FirebaseFirestore.instance
      .collection("users")
      .doc("yPIYUsHuF6NqJGL10k9h")
      .update({
        "email" : "kriss123@gmail.com"
      });

      print("user updated");


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null)
          ? const HomeScreen()
          : LoginScreen(),
    );
  }
}

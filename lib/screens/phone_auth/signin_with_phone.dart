import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/components/textfield.dart';
import 'package:flutter_firebase/screens/phone_auth/verify_otp.dart';

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({super.key});

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  TextEditingController phoneTextController = TextEditingController();

  void sendOTP() async {
    String phone = "+91${phoneTextController.text.trim()}";
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: ((verificationId, forceResendingToken) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => VerifyOTPScreen(verificationId:verificationId),
          ),
        );
      }),
      verificationCompleted: (credential) {},
      verificationFailed: (ex) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Some error with verification"),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 150,
              ),
              const Text(
                "SignIn Page",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: MyTextField(
                  hintText: "Phone Number",
                  obscure: false,
                  textController: phoneTextController,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        sendOTP();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Send OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

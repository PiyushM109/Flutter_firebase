import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/components/textfield.dart';
import 'package:flutter_firebase/screens/emai_auth/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
              size: 100,
            ),
            const Text(
              "Create an account",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: MyTextField(
                hintText: 'Email',
                obscure: false,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: MyTextField(
                hintText: 'Password',
                obscure: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: MyTextField(
                hintText: 'Confirm Password',
                obscure: true,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      
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
                          'SignUp',
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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already Have an account go to "),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Login Page",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'components/textfield.dart';
import 'emai_auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => LoginScreen()));
  }

  void saveUser() {
    String name = nameController.text.toString();
    String email = emailController.text.toString();
    String ageString = ageController.text.toString();

    int age = int.parse(ageString);
    nameController.clear();
    emailController.clear();
    ageController.clear();

    if (name != "" && email != "") {
      Map<String, dynamic> newUser = {
        "name": name,
        "email": email,
        "age" : age,
      };

      FirebaseFirestore.instance.collection("users").add(newUser);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Data is added"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please fill all the data"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Data Collection",
          style: TextStyle(
            fontWeight: FontWeight.bold,
    
          ),
        ),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          )
        ],
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyTextField(
                hintText: "Name",
                obscure: false,
                textController: nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyTextField(
                hintText: "Email Address",
                obscure: false,
                textController: emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyTextField(
                hintText: "Age",
                obscure: false,
                textController: ageController,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      saveUser();
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
                          'Save',
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
              height: 30,
            ),
            const Text(
              "Current Users",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("users").orderBy("age", descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> userMap =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          String documentId = snapshot.data!.docs[index].id;
                          return Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(top:10, left: 8, right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                            child: ListTile(
                              title: Text(userMap["name"]),
                              subtitle: Text(userMap["email"] + "  (age: ${userMap["age"]})"),
                              trailing: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(documentId)
                                      .delete()
                                      .then((value) {
                                    // Delete successful
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.lightBlue,
                                        content: Text("User deleted"),
                                      ),
                                    );
                                  }).catchError((error) {
                                    // Error occurred while deleting the document
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("Error occured"),
                                      ),
                                    );
                                  });
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("There is some unkown Error"),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

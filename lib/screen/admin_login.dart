

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sale_tracker/screen/dashboard.dart';
import 'package:sale_tracker/screen/start.dart';
import 'package:sale_tracker/screen/tabScreen.dart';
import 'package:http/http.dart' as http;

import 'admin_tabScreen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  String loginText = "Login with user name and password";
  bool _isLoading = false;

  _login(String username, password,  BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    if (userName.text.trim().isEmpty || password.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Invalid Data'),
          content: const Text('Please make sure you enter an Id Data'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }

    final url = Uri.https(
        'sale-tracker-e4ae0-default-rtdb.firebaseio.com', 'user-list.json');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Successful API call
        Map<String, dynamic> userList = json.decode(response.body);

        // Check if the user exists in the list
        bool userExists = false;
        for (final user in userList.entries) {
          if (user.value['name'] == username && user.value['password'] == password) {
            // Replace 'id' with the actual key in your user data
            userExists = true;
            break;
          }
        }

        if (userExists) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (ctx) => AdminTabScreen()),
          );
        } else {

          setState(() {
            _isLoading = false;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Invalid Data'),
              content: const Text('User does not exist.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay"),
                ),
              ],
            ),
          );

        }
      }
    } catch (e) {
      // Handle exceptions such as network errors
      print('Error during API call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 72, 154, 107),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const StartScreen() ),);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Sale Admin Login",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Center(
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [BoxShadow(blurRadius: 10.0)],
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                          width: 5,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        )),

                      child: TextField(
                        controller: userName,
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.local_library_rounded),
                          hintText: "User Name",
                        ),
                      ),
                    ),
                  ),


                Center(
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [BoxShadow(blurRadius: 10.0)],
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                          width: 5,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        )),
                      child: TextField(
                        controller: password,
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_clock_sharp),
                          hintText: "password",
                        ),
                      ),
                    ),
                  ),

                const SizedBox(
                  height: 40,
                ),
                _isLoading
                    ? const CircularProgressIndicator(
                  color: Color.fromARGB(255, 72, 154, 107),
                  semanticsLabel: "Please wait!",
                )
                    : OutlinedButton.icon(
                  onPressed: () {
                    _login(userName.text, password.text, context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                    const Color.fromARGB(255, 72, 154, 107),
                  ),
                  icon: const Icon(Icons.login_outlined),
                  label: Text(loginText),
                ),

              ],
            ),
            //const Divider(color: Color.fromARGB(255, 241, 156, 0),),
          ],
        ),
      ),
    );
  }
}

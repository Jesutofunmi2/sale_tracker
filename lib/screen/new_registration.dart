import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sale_tracker/screen/start.dart';
import 'package:http/http.dart' as http;

import 'admin_tabScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  String loginText = "Save New Staff Record";
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  _save(String username, password, email, phone, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final url = Uri.https(
      'sale-tracker-e4ae0-default-rtdb.firebaseio.com', 'user-list.json');
      http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'name': username,
            'password': password,
            'email': email,
            'phone': phone
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Register New Staff",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
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
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(blurRadius: 10.0)],
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                          width: 5,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        )),
                    child: Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter user name';
                          }
                          return null;
                        },
                        controller: userName,
                        style: const TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.local_library_rounded),
                          hintText: "user name",
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(blurRadius: 10.0)],
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        )),
                    child: Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter user phone';
                          }
                          return null;
                        },
                        controller: phone,
                        style: const TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: "phone",
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(blurRadius: 10.0)],
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        )),
                    child: Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter user email';
                          }
                          return null;
                        },
                        controller: email,
                        style: const TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: "email",
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(blurRadius: 10.0)],
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        )),
                    child: Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter user password';
                          }
                          return null;
                        },
                        controller: password,
                        style: const TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_clock_sharp),
                          hintText: "password",
                        ),
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
                          _save(userName.text, password.text, phone.text,
                              email.text, context);
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

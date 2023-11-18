import 'package:flutter/material.dart';
import 'package:sale_tracker/screen/dashboard.dart';
import 'package:sale_tracker/screen/start.dart';
import 'package:sale_tracker/screen/tabScreen.dart';

import 'admin_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController saleId = TextEditingController();
  String loginText = "Login with Sales ID";
  bool _isLoading = false;

  _login(String Id, BuildContext context) {
    setState(() {
      _isLoading = true;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => TabScreen()),
    );
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
      body: Column(
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
                  "Sale Attendance",
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
                  child: Expanded(
                    child: TextField(
                      controller: saleId,
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_clock_sharp),
                        hintText: "Sales Password",
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
                        _login(saleId.text, context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromARGB(255, 72, 154, 107),
                      ),
                      icon: const Icon(Icons.login_outlined),
                      label: Text(loginText),
                    ),

              const SizedBox(
                height: 6,
              ),

              OutlinedButton.icon(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const  AdminLoginScreen(),),);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                  const Color.fromARGB(255, 72, 154, 107),
                ),
                icon: const Icon(Icons.login_outlined),
                label:const Text("Sales Admin Login"),
              ),
            ],
          ),
          //const Divider(color: Color.fromARGB(255, 241, 156, 0),),
        ],
      ),
    );
  }
}

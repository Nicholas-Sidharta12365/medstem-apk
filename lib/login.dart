import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medstem/main.dart';
import 'dart:convert';
import 'package:medstem/widgets/drawer.dart';

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        drawer: DrawerClass(),
        body: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: const AssetImage("assets/home.png"),
              fit: BoxFit.cover,
              opacity: 0.5,
            ) 
          ),
          child: Form(
            key: _loginFormKey,
            child: Center(
              child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 3))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // Username Field
                        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: TextFormField(
                          onChanged: (value) {
                            username = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username must not empty!";
                            }
                            if (value.length < 4) {
                              return "Username must at least contains 4 characters!";
                            }
                            return null;
                          },
                          maxLength: 15,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.alternate_email_rounded,
                                color: Colors.grey,
                              ),
                              labelText: "Username",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Enter your username",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      Column(
                        // Password Field
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: TextFormField(
                              onChanged: (value) {
                                password = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password must not empty!";
                                }
                                return null;
                              },
                              obscureText: true,
                              maxLength: 20,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock_rounded,
                                    color: Colors.grey,
                                  ),
                                  labelText: "Password",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Enter your password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        // Button Login
                        width: MediaQuery.of(context).size.width / 2,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(80, 50),
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.greenAccent.shade700,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                          ),
                          onPressed: () async {
                            if (_loginFormKey.currentState!.validate()) {
                              final response = await request.post(
                                      "https://medstem.up.railway.app/login-flutter/",
                                       jsonEncode(<String, String>{
                                    'username': username,
                                    'password': password
                                  }));
                              // print(response.body);
                              bool status = response['status'];
                              request.loggedIn = true;
                              // print(jsonDecode(response.body));
                              if (status) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Row(
                                  children: const [
                                    Icon(Icons.info_outline_rounded,
                                        size: 30, color: Colors.white),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Text("Login successful",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20))
                                  ],
                                )));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyHomePage(title: "Home")));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Row(
                                  children: const [
                                    Icon(Icons.warning_amber_rounded,
                                        size: 30, color: Colors.white),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Text("Username or password does not exist!",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20))
                                  ],
                                )));
                              }
                            }
                          },
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(letterSpacing: 2),
                          ),
                        ),
                      ),
                    ],
                  )),
            ))));
  }
}

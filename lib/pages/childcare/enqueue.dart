import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medstem/model/childcaremodel.dart';
import 'package:medstem/widgets/drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Enqueue extends StatelessWidget {
  const Enqueue({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedStem',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const EnqueueForm(),
    );
  }
}

class EnqueueForm extends StatefulWidget {
  const EnqueueForm({super.key});

  @override
  EnqueueFormState createState() => EnqueueFormState();
}

class EnqueueFormState extends State<EnqueueForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _doctor = "";
  String _description = "";

  CookieRequest? get request => null;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Image.asset(
            'assets/med_logo.png',
            height: 30,
            width: 30,
          ),
          const Text(" Enqueue"),
        ]),
      ),
      drawer: const DrawerClass(),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40, bottom: 40),
            child: const Text(
              "ENQUEUE",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 60, right: 60),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Doctor',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Doctor name';
                      }
                      return null;
                    },
                    onSaved: (value) => _doctor = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    onSaved: (value) => _description = value!,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 40),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final response = await request.post(
                              'https://medstem.up.railway.app/childcare/flutter_add/',
                              jsonEncode(<String, String>{
                                "name": _name,
                                "doctor": _doctor,
                                "description": _description,
                              }));
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 60, right: 60),
            child: ElevatedButton(
                onPressed: () {
                  // Handle the enqueue button press here
                  Navigator.pop(
                    context,
                  );
                },
                child: const Text("Back")),
          )
        ],
      ),
    );
  }
}

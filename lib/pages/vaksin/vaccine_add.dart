import 'dart:convert';
import 'package:medstem/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medstem/model/vaccine_data.dart';
import 'package:flutter/services.dart';
import 'package:medstem/pages/vaksin/vaccine_data_page.dart';

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class VaccineAddPage extends StatefulWidget {
  const VaccineAddPage({Key? key}) : super(key: key);

  @override
  _VaccineAddPageState createState() => _VaccineAddPageState();
}

class _VaccineAddPageState extends State<VaccineAddPage> {
  String name = '';
  String sideEffect = '';
  String dose = '0';
  String stock = '0';

  final GlobalKey<FormState> _formKey = GlobalKey();

  Widget build(BuildContext context) {
  final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Vaksin')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "e.g: Sinovac",
                      labelText: 'Nama Vaksin',
                      icon: const Icon(Icons.book),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ) 
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        name = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        name = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Field Nama Vaksin tidak boleh kosong";
                      }
                      return null;
                    },
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "e.g: migrain",
                      labelText: 'Efek Samping',
                      icon: const Icon(Icons.dangerous),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ) 
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        sideEffect = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        sideEffect = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Field Efek Samping tidak boleh kosong";
                      }
                      return null;
                    },
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "e.g: 10.0",
                      labelText: 'Dosis',
                      icon: const Icon(Icons.medication_liquid_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ) 
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),],
                    onChanged: (value) {
                      setState(() {
                        dose = value;
                      });
                    },
                    // onSaved: (value) {
                    //   setState(() {
                    //     dose = value!;
                    //     print(dose);
                    //   });
                    // },
                    validator: (String? value) {
                      if (dose == null || dose.isEmpty) {
                        return "Field Dosis tidak boleh kosong";
                      }
                      return null;
                    },
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "e.g: 1000",
                      labelText: 'Stok',
                      icon: const Icon(Icons.list_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ) 
                    ),
                    keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                    ],
                    onChanged: (value) {
                      setState(() {
                        stock = value;
                      });
                    },
                    // onSaved: (value) {
                    //   setState(() {
                    //     stock = value!;
                    //   });
                    // },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Field stock tidak boleh kosong";
                      }
                      return null;
                    },
                  )
                ),
                // Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                TextButton(
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await request.post(
                        'https://medstem.up.railway.app/vaksin/flutter-add/',
                         jsonEncode(<String, String>{
                                    'name': name,
                                    'sideEffect': sideEffect,
                                    'dose': dose,
                                    'stock': stock,
                                  })
                      );
                      Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const VaccineDataPage()));
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 15,
                            child: Container(
                              child: ListView(
                                padding: const EdgeInsets.only(top: 20, bottom: 20),
                                shrinkWrap: true,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  // TODO: Munculkan informasi yang didapat dari form
                                  const Text(
                                    'Data berhasil ditambahkan',
                                    textAlign: TextAlign.center,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Kembali'),
                                  ), 
                                ],
                              ),
                            ),
                          );
                        }
                      );
                    }
                  },
                ),
              ])
                
              ],
              )
          )
        )
      )
    );
  }
}
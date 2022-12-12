import 'dart:convert';
import 'package:medstem/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medstem/model/vaccine_data.dart';
import 'package:flutter/services.dart';
import 'package:medstem/pages/vaksin/vaccine_data_page.dart';

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class EditDosePage extends StatefulWidget {
  const EditDosePage({Key? key}) : super(key: key);

  @override
  _EditDosePageState createState() => _EditDosePageState();
}

class _EditDosePageState extends State<EditDosePage> {
  String newDose = '';
  String vaksin = 'sinovac';
  List<String> data_vaksin = VaccineDetails.dataSaved;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build (BuildContext context) {
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
                      hintText: "e.g: 10.0",
                      labelText: 'Dosis Baru',
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
                        newDose = value;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Field Dosis tidak boleh kosong";
                      }
                      return null;
                    },
                  )
                ),
                ListTile(       
                trailing: DropdownButton(
                    alignment: AlignmentDirectional.topEnd,
                    value: vaksin,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: data_vaksin.map((String items) {  
                    return DropdownMenuItem(
                        child: Text(items, textAlign: TextAlign.center),
                        value: items,
                    );
                    
                    }).toList(),
                    onChanged: (String? newValue) {
                    setState(() {
                        vaksin = newValue!;
                    });
                    },
                ),
              ),
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
                        'https://medstem.up.railway.app/vaksin/flutter-edit/',
                         jsonEncode(<String, String>{
                                    'name': vaksin,
                                    'dose': newDose,
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
              ],)
              ],
              )
          )
        )
      )
    );
  }
}
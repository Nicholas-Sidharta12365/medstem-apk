import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medstem/pages/apotek/apotek.dart';
import 'package:medstem/pages/apotek/meds_list.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  String patient_name = '';
  String patient_age = '';
  String _jeniskelamin = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();

  void _choosejeniskelamin(value) {
    setState(() {
      _jeniskelamin = value;
    });
  }

// ignore: non_constant_identifier_names
  void send_data() {
    showDialog(
        context: context,
        // ignore: unnecessary_new
        builder: (ctxt) => new AlertDialog(
            content: Container(
                height: 200.0,
                child: Column(
                  children: <Widget>[
                    Text("Patient Name: ${nameController.text}"),
                    Text("Patient Age: ${ageController.text}"),
                    Text("Diagnosis: ${diagnosisController.text}"),
                    Text("Sex: $_jeniskelamin"),
                    ElevatedButton(
                        child: new Text("OK"),
                        onPressed: () => Navigator.pop(context))
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Add Prescription'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Patient Name",
                      labelText: "Patient Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  onChanged: (String? value) {
                    setState(() {
                      patient_name = value!;
                    });
                  },
                  // onSaved: (String? value) {
                  //   setState(() {
                  //     patient_name = value!;
                  //   });
                  // },
                  // validator: (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Patient name cannot be empty!";
                  //   }
                  //   return null;
                  // },
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                      hintText: "Patient Age",
                      labelText: "Patient Age",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                TextField(
                  controller: diagnosisController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "Diagnosis",
                      labelText: "Diagnosis",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                RadioListTile(
                  value: "Wanita",
                  title: const Text("Wanita"),
                  groupValue: _jeniskelamin,
                  onChanged: (value) {
                    _choosejeniskelamin(value);
                  },
                  activeColor: Colors.red,
                ),
                RadioListTile(
                  value: "Pria",
                  title: const Text("Pria"),
                  groupValue: _jeniskelamin,
                  onChanged: (value) {
                    _choosejeniskelamin(value);
                  },
                  activeColor: Colors.red,
                ),
                ElevatedButton(
                    child: const Text("OK"),
                    onPressed: () {
                      send_data();
                    }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyMedicationPage(
              patient_name: nameController.text,
              patient_age: ageController.text,
              // : diagnosisController.text,
              patient_gender: _jeniskelamin,
            )),
          );
        },
      ),
    );
  }
}

class MyMedicationPage extends StatefulWidget {
  final String patient_name;
  final String patient_age;
  final String patient_gender;

  const MyMedicationPage({
    super.key,
    required this.patient_name,
    required this.patient_age,
    required this.patient_gender,
  });

  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MyMedicationPage> {
  List<Map> staticData = MyMedicineData.data;
  Map<int, bool> selectedFlag = {};
  String patient_name = '';
  String patient_age = '';
  String patient_gender = '';

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Medications'),
      ),
      body: ListView.builder(
        itemBuilder: (builder, index) {
          Map data = staticData[index];
          selectedFlag[index] = selectedFlag[index] ?? false;
          bool isSelected = selectedFlag[index]!;

          return ListTile(
            onTap: () => onTap(isSelected, index),
            title: Text("${data['name']}"),
            subtitle: Text("${data['email']}"),
            leading: _buildSelectIcon(isSelected, data),
          );
        },
        itemCount: staticData.length,
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Container(
                    height: 200.0,
                    child: Column(
                      children: <Widget>[
                        Text("Patient Name: ${widget.patient_name}"),
                        Text("Patient Age: ${widget.patient_age}"),
                        // Text("Diagnosis: ${widget.diagnosis}"),
                        Text("Sex: ${widget.patient_gender}"),
                        Text("Prescription: "),
                        Column(
                          children: List.generate(staticData.length, (index) {
                            if (selectedFlag[index] == true) {
                              return Text(staticData[index]['name']);
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                        ),
                        ElevatedButton(
                            child: new Text("Back"),
                            onPressed: () => Navigator.pop(context)),
                        ElevatedButton(
                            child: new Text("Add"),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                          final response = await request.post(
                            'https://medstem.up.railway.app/apotek/json/',
                            jsonEncode(<String, String>{
                              'patient_name': patient_name,
                              'patient_age': patient_age,
                              'patient_gender': patient_gender,
                              // 'medicine': medicine,
                            })
                          );

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Apotek()));
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
                      ],
                    )),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    ); // floatingActionButton: _buildSelectAllButton(),
  }

  void onTap(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
    });
  }

  Widget _buildSelectIcon(bool isSelected, Map data) {
    return Icon(
      isSelected ? Icons.check_box : Icons.check_box_outline_blank,
      color: Theme.of(context).primaryColor,
    );
  }
}

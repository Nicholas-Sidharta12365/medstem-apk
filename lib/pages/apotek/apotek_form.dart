import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medstem/pages/apotek/apotek.dart';
import 'package:medstem/pages/apotek/meds_list.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ApotekFormPage extends StatefulWidget {
  const ApotekFormPage({Key? key}) : super(key: key);

  @override
  _ApotekFormPageState createState() => _ApotekFormPageState();
}

class _ApotekFormPageState extends State<ApotekFormPage> {
  String patient_name = "";
  String patient_age = "";
  String _jeniskelamin = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  void _choosejeniskelamin(value) {
    setState(() {
      _jeniskelamin = value;
    });
  }

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
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          // controller: nameController,
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
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20.0)),
                        TextField(
                          // controller: ageController,
                          decoration: InputDecoration(
                              hintText: "Patient Age",
                              labelText: "Patient Age",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          onChanged: (value) {
                            setState(() {
                              patient_age = value;
                            });
                          },
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
                        FloatingActionButton(
                            child: Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyMedicationPage(
                                          patient_name: patient_name,
                                          patient_age: patient_age,
                                          // : diagnosisController.text,
                                          patient_gender: _jeniskelamin,
                                        )),
                              );
                            }),
                      ],
                    )))));
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
            subtitle: Text("${data['detail']}"),
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
                    height: 700.0,
                    child: Column(
                      children: <Widget>[
                        Text("Patient Name: ${widget.patient_name}"),
                        Text("Patient Age: ${widget.patient_age}"),
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
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          child: const Text("Add Prescription"),
                          onPressed: () async {
                            var medicine = '';
                            for (int i = 0; i < staticData.length; i++) {
                              if (selectedFlag[i] == true) {
                                medicine += staticData[i]['name'].toString();
                                if (i + 1 != staticData.length) {
                                  medicine += ', ';
                                }
                              }
                            }

                            final response = await request.post(
                                'https://medstem.up.railway.app/apotek/flutter-add/',
                                jsonEncode(<String, dynamic>{
                                  'patientName': widget.patient_name,
                                  'patientAge': int.parse(widget.patient_age),
                                  'patientGender': widget.patient_gender,
                                  'medicine': medicine,
                                }));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ApotekMainPage()));
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
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        const SizedBox(height: 20),
                                        const Text(
                                          'Patient succesfully added!',
                                          textAlign: TextAlign.center,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Back'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    )),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.check_circle),
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

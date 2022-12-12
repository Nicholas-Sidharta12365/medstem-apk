import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../widgets/drawer.dart';
import 'apotek_form.dart';
import 'package:medstem/model/apotek_model.dart';

class Apotek extends StatelessWidget {
  const Apotek({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedStem',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const ApotekPage(title: 'Apotek'),
    );
  }
}

class ApotekPage extends StatefulWidget {
  const ApotekPage({super.key, required this.title});

  final String title;

  @override
  State<ApotekPage> createState() => _ApotekPageState();
}

class _ApotekPageState extends State<ApotekPage> {
  Future<List<PatientData>> fetchPatientData(CookieRequest request) async {
    // decode the response into the json form
    var data = await request.get('https://medstem.up.railway.app/apotek/json/');

    // convert the json data into VaccineData object
    List<PatientData> listPatient = [];
    for (var d in data) {
      if (d != null) {
        listPatient.add(PatientData.fromJson(d));
      }
    }

    print(listPatient);
    return listPatient;
  }

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
          Text(" ${widget.title}"),
        ]),
      ),
      drawer: const DrawerClass(),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 40, top: 40),
            child: const Text(
              "PHARMACY",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "About",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 60, right: 60, bottom: 40),
            child: const Text(
              "With the Pharmacy feature in MedStem, making and tracking patient prescriptions has never been easier! Pharmacy allows you to add prescriptions with the corresponding patient data to better organize your day-to-day activities!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          // const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyFormPage()),
                  );
                },
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                  Image.asset('assets/apotek/add_patient.PNG',
                    height: 70,
                    width: 70,
                  ),
                   const Text("Add Patient")
                    ],
                  )
                  ),
                ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) => const MyFormPage(),
                      ),
                    );
                  },
                  child: Column( // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Image.asset('assets/apotek/med_list.PNG',
                        height: 70,
                        width: 70,
                          ),
                          const Text("Medication List")
                  ],
                  ),
                ),
          ],
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Patient List",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: fetchPatientData(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data;
                if (data == null) {
                  return Container(
                    child: Text('data kosong'),
                  );
                }
                return Column(
                  children: List.generate(
                      data.length, (index) => const PatientCard()),
                );
              }
            },
          ),
          ],
        ),
    );
  }
}

class PatientCard extends StatelessWidget {
  const PatientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: const [
            Text('Naila Azizah'),
            Text('17 Tahun'),
          ],
        ),
      ),
    );
  }
}

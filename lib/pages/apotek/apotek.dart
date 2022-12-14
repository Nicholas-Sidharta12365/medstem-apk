import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../widgets/drawer.dart';
import 'apotek_form.dart';
import 'meds_list.dart';
import 'package:medstem/model/apotek_model.dart';

class Apotek {
  static late Fields _getDetails;
  static Fields get fetcher => _getDetails;
  static late List<String> _dataSaved = [];
  static List<String> get dataSaved => _dataSaved;
}

class ApotekMainPage extends StatefulWidget {
  const ApotekMainPage({Key? key}) : super(key: key);

  @override
  _ApotekMainPageState createState() => _ApotekMainPageState();
}

class _ApotekMainPageState extends State<ApotekMainPage> {
  Future<List<PatientData>> fetchPatientData(CookieRequest request) async {
    // response to json
    var data = await request.get('https://medstem.up.railway.app/apotek/json/');

    List<PatientData> listPatients = [];
    for (var d in data) {
      if (d != null) {
        listPatients.add(PatientData.fromJson(d));
        Apotek._dataSaved.add(PatientData.fromJson(d).fields.patient_name);
      }
    }
    return listPatients;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    bool status = request.loggedIn;
    ScrollController _controller = new ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Image.asset(
            'assets/med_logo.png',
            height: 30,
            width: 30,
          ),
          const Text("Pharmacy"),
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
                      MaterialPageRoute(builder: (context) => const ApotekFormPage()),
                    );
                  },
                  child: Column( // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Image.asset('apotek/add_patient.PNG',
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
                    MaterialPageRoute(builder: (context) => MyMedicationListPage(),
                    ),
                  );
                },
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Image.asset('apotek/med_list.PNG',
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
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "No Patients Yet",
                          style:
                          TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black, blurRadius: 2.0)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Apotek._getDetails = snapshot.data![index].fields;
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
                                                  Center(child: const Text('Patient Details')),
                                                  SizedBox(height: 20),
                                                  Text(
                                                    Apotek.fetcher.patient_name.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 20),
                                                  ),
                                                  Text(
                                                    "User ID : " + Apotek.fetcher.user.toString(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "Patient Name: " + Apotek.fetcher.patient_name,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "Patient Age: " + Apotek.fetcher.patient_age.toString() + " Tahun",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "Patient Sex: " + Apotek.fetcher.patient_gender.toString(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "Prescription: ",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    Apotek.fetcher.medicine.toString(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  FloatingActionButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Back'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    "${snapshot.data![index].fields.patient_name}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pinkAccent,
                                    ),
                                  )
                              ),
                              const SizedBox(height: 8),
                              //Spacer(),

                            ],
                          ),
                        ));
                  }
                }
              }),
        ],
      ),
    );
  }
}



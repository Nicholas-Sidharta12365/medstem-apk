import 'dart:convert';
import 'package:medstem/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medstem/model/vaccine_data.dart';
import 'package:medstem/pages/vaksin/vaccine_add.dart';
import 'package:medstem/pages/vaksin/vaccine_user.dart';
import 'package:medstem/pages/vaksin/edit_dose.dart';
import 'package:medstem/login.dart';

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class VaccineDetails {
  static late Fields _getDetails;
  static Fields get fetcher => _getDetails;
  static late List<String> _dataSaved = [];
  static List<String> get dataSaved => _dataSaved;
}

class VaccineDataPage extends StatefulWidget {
  const VaccineDataPage({Key? key}) : super(key: key);

  @override
  _VaccineDataPageState createState() => _VaccineDataPageState();
}

class _VaccineDataPageState extends State<VaccineDataPage> {
  Future<List<VaccineData>> fetchVaccineData(CookieRequest request) async {
    // decode the response into the json form
    var data = await request.get('https://medstem.up.railway.app/vaksin/json/');

    // convert the json data into VaccineData object
    List<VaccineData> listVaccineData = [];
    for (var d in data) {
      if (d != null) {
        listVaccineData.add(VaccineData.fromJson(d));
        VaccineDetails._dataSaved.add(VaccineData.fromJson(d).fields.name);
      }
    }
    return listVaccineData;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    bool status = request.loggedIn;
    ScrollController _controller = new ScrollController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Vaksin'),
        ),
        drawer: DrawerClass(),
        body: 
        
        child:Column(
        // controller: _controller,
          children: [
              if (status)...[
              TextButton(
                child: const Text(
                  "Vaksin User",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VaccineUserPage()));
                }
              ),
            FutureBuilder(
                future: fetchVaccineData(request),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    // print("null geming");
                    return const Center(child: CircularProgressIndicator());
                    // return const Text("404 Sadge");
                  } else {
                    if (!snapshot.hasData) {
                      return Column(
                        children: const [
                          Text(
                            "Data Vaksin Kosong",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
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
                                        VaccineDetails._getDetails = snapshot.data![index].fields;
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
                                              Center(child: const Text('Vaccine Details')),
                                              SizedBox(height: 20),
                                              // TODO: Munculkan informasi yang didapat dari form
                                              Text(
                                                VaccineDetails.fetcher.name.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 24),
                                                ),
                                              Text(
                                                "Posted By User ID : " + VaccineDetails.fetcher.user.toString(),
                                                textAlign: TextAlign.center,
                                                ),
                                              Text(
                                                VaccineDetails.fetcher.date.toString(),
                                                textAlign: TextAlign.center,
                                                ),
                                              Text(
                                                "Efek Samping : " + VaccineDetails.fetcher.sideEffect,
                                                textAlign: TextAlign.center,
                                                ),
                                              Text(
                                                "Total Dosis : " + VaccineDetails.fetcher.dose.toString() + " mg",
                                                textAlign: TextAlign.center,
                                                ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Kembali'),
                                              ), 
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                      },
                                      child: Text(
                                      "${snapshot.data![index].fields.name}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                      )
                                    ),
                                    const SizedBox(height: 10),
                                    //Spacer(),
                                    
                                  ],
                                ),
                              ));
                    }
                  }
                }),
              
                Center(
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                  Padding(
                    padding: EdgeInsets.only(right: 4, left:4),
                    child: 
                    TextButton(
                        child: const Text(
                          "Add Vaksin",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VaccineAddPage()));
                        }
                      ),
                    ),
                      Padding(
                        padding: EdgeInsets.only(right: 4, left:4),
                        child: 
                      TextButton(
                          child: const Text(
                            "Edit Dose",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditDosePage()));
                          }
                        ),
                        )
                    ],)
                  )
              ] else ...[
                Center(child: Column(children: [
                  const Text(
                    "Please Log In First",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                TextButton(
                    child: const Text(
                      "Log In",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    }
                  ),
                ]),
                )
              ]    
            ],)

        
            );

  }
}
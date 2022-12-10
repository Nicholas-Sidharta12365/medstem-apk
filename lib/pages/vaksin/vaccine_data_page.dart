import 'dart:convert';
import 'package:medstem/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medstem/model/vaccine_data.dart';

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class VaccineDetails {
  static late Fields _getDetails;
  static Fields get fetcher => _getDetails;
}

class VaccineDataPage extends StatefulWidget {
  const VaccineDataPage({Key? key}) : super(key: key);

  @override
  _VaccineDataPageState createState() => _VaccineDataPageState();
}

class _VaccineDataPageState extends State<VaccineDataPage> {
  Future<List<VaccineData>> fetchVaccineData(CookieRequest request) async {
    // decode the response into the json form
    var data = await request.get('https://medstem.up.railway.app/vaksin/json1/');

    // convert the json data into VaccineData object
    List<VaccineData> listVaccineData = [];
    for (var d in data) {
      if (d != null) {
        listVaccineData.add(VaccineData.fromJson(d));
      }
    }
    return listVaccineData;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Vaksin'),
        ),
        drawer: DrawerClass(),
        body: FutureBuilder(
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
                                            "Total Dosis : " + VaccineDetails.fetcher.dose.toString(),
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
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}
import 'dart:convert';
import 'package:medstem/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medstem/model/vaccine_data.dart';
import 'package:medstem/pages/vaksin/vaccine_data_page.dart';

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class VaccineDetailsUser {
  static late Fields _getDetails;
  static Fields get fetcher => _getDetails;
}

class VaccineUserPage extends StatefulWidget {
  const VaccineUserPage({Key? key}) : super(key: key);

  @override
  _VaccineUserPageState createState() => _VaccineUserPageState();
}

class _VaccineUserPageState extends State<VaccineUserPage> {
  Future<List<VaccineData>> fetchVaccineUserData(CookieRequest request) async {
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
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Data Vaksin'),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/vaksin-ifloggin!.png"), fit: BoxFit.fill),
          ),
          child: Column(children: [
          const SizedBox(height: 10),
          TextButton(
                child: const Text(
                  "Kembali",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  Navigator.pop(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VaccineDataPage()));
                }
              ),
          Expanded(
            flex: 2,
            child:
          FutureBuilder(
              future: fetchVaccineUserData(request),
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
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 50, 100),
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
                                      VaccineDetailsUser._getDetails = snapshot.data![index].fields;
                                      showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 15,
                                      child: SingleChildScrollView(child: Column(
                                        children: [ ListView(
                                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            Center(child: const Text('Vaccine Details')),
                                            SizedBox(height: 20),
                                            // TODO: Munculkan informasi yang didapat dari form
                                            Text(
                                              VaccineDetailsUser.fetcher.name.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 24),
                                              ),
                                            Text(
                                              VaccineDetailsUser.fetcher.date.toString(),
                                              textAlign: TextAlign.center,
                                              ),
                                            Text(
                                              "Efek Samping : " + VaccineDetailsUser.fetcher.sideEffect,
                                              textAlign: TextAlign.center,
                                              ),
                                            Text(
                                              "Total Dosis : " + VaccineDetailsUser.fetcher.dose.toString() + " mg",
                                              textAlign: TextAlign.center,
                                              ),
                                            Text(
                                              "Stok Vaksin : " + VaccineDetailsUser.fetcher.stock.toString(),
                                              textAlign: TextAlign.center,
                                              ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                  builder: (context) => const VaccineDataPage()));
                                              },
                                              child: Text('Kembali'),
                                            ), 
                                          ],
                                        ),
                                    ])),        
                                    );
                                  });
                                    },
                                    child: Text(
                                    "${snapshot.data![index].fields.name}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
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
          ),
            ])

        ));
  }
}
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:medstem/widgets/drawer.dart';
import 'package:medstem/utils/kasir_fetch.dart';
import 'package:medstem/pages/kasir/kasir_create_bill.dart';
import 'package:medstem/pages/kasir/kasir_payment_bill.dart';
import 'package:medstem/pages/kasir/kasir_delete_bill.dart';

class Kasir extends StatelessWidget {
  const Kasir({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedStem',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const KasirPage(title: 'Checkout'),
    );
  }
}

class KasirPage extends StatefulWidget {
  const KasirPage({super.key, required this.title});

  final String title;

  @override
  State<KasirPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<KasirPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(children: [
          Image.asset(
            'assets/med_logo.png',
            height: 30,
            width: 30,
          ),
          Text(" ${widget.title}"),
        ]),
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder(
          future: fetchChasier(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: const [
                    Text(
                      "Tidak ada bill :(",
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(5.0),
                            color: snapshot
                                    .data![index].fields.patientStatusPayment
                                ? Colors.greenAccent.shade400
                                : Colors.redAccent.shade700,
                            shadowColor: Colors.blueGrey,
                            child: ListTile(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 400,
                                      child: Center(
                                        child: ElevatedButton(
                                          child: const Text('Close'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              // ignore: prefer_interpolation_to_compose_strings
                              title: Text('Patient: ' +
                                  snapshot.data![index].fields.patient +
                                  '\nDoctor: ' +
                                  snapshot.data![index].fields.doctor),
                              // ignore: prefer_interpolation_to_compose_strings
                              trailing: Text('Bill: ' +
                                  snapshot.data![index].fields.bill.toString()),
                            ))));
              }
            }
          }),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.black,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 12,
        spaceBetweenChildren: 12,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            label: 'Create Bill',
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 400,
                    child: Center(
                      child: ElevatedButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.payment),
            label: 'Payment Bill',
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 400,
                    child: Center(
                      child: ElevatedButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.browser_updated),
            label: 'Update Bill',
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 400,
                    child: Center(
                      child: ElevatedButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.auto_delete),
            label: 'Delete Bill',
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 600,
                    child: Center(
                      child: ElevatedButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods
    );
  }
}

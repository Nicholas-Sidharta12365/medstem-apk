// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:medstem/widgets/drawer.dart';
import 'package:medstem/utils/kasir_fetch.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
      home: const KasirPage(),
    );
  }
}

class KasirPage extends StatefulWidget {
  const KasirPage({super.key});

  @override
  State<KasirPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<KasirPage> {
  final _kasirFormKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  String _doctor = '';
  String _patient = '';
  String _description = '';
  String _bill = '';
  int _money_paid = 0;
  int _kembalian = 0;
  bool _berhasil = false;
  int id = 0;

  void paymentMethod(String bill) {
    _kembalian = _money_paid - int.parse(bill);
    if (_kembalian >= 0) {
      _berhasil = true;
    } else {
      _berhasil = false;
    }
  }

  void refreshWidget() {
    setState(() {});
  }

  Future<http.Response> deleteBill(int id) async {
    var url = 'https://medstem.up.railway.app/kasir/delete_flutter/$id/';
    final http.Response response = await http.delete(
      Uri.parse(
        url,
      ),
    );
    return response;
  }

  Future<http.Response> paymentBill(int id) async {
    var url = 'https://medstem.up.railway.app/kasir/payment_flutter/$id/';
    final http.Response response = await http.post(
      Uri.parse(
        url,
      ),
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final DateFormat formatter = DateFormat('MMM dd, yyyy');

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
          Text(
            " Checkout",
            style: TextStyle(color: Colors.black),
          ),
        ]),
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: const DrawerClass(),
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
                  addAutomaticKeepAlives: false,
                  cacheExtent: 100.0,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(5.0),
                        color: snapshot.data![index].fields.patientStatusPayment
                            ? Colors.greenAccent.shade400
                            : Colors.redAccent.shade700,
                        shadowColor: Colors.blueGrey,
                        child: ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(20.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                snapshot.data![index].fields
                                                    .patient,
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            ]),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Doctor: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              snapshot
                                                  .data![index].fields.doctor,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Check-in Date: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formatter
                                                  .format(snapshot
                                                      .data![index].fields.date)
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Bill: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              snapshot.data![index].fields.bill
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Status Pembayaran: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              snapshot.data![index].fields
                                                      .patientStatusPayment
                                                  ? 'Already paid'
                                                  : 'Not yet paid',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Description: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              snapshot.data![index].fields
                                                  .description,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        child: const Text('Close'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          // ignore: prefer_interpolation_to_compose_string
                          leading: Visibility(
                            visible: !snapshot
                                    .data![index].fields.patientStatusPayment &
                                request.loggedIn,
                            child: SizedBox.fromSize(
                              size: Size(60, 60),
                              child: ClipOval(
                                child: Material(
                                  color: Colors.black,
                                  child: InkWell(
                                    splashColor: Colors.green,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Payment Method'),
                                          content: TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: "Cash",
                                              // Menambahkan icon agar lebih intuitif
                                              icon: const Icon(Icons.people),
                                              // Menambahkan circular border agar lebih rapi
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
                                            // Menambahkan behavior saat nama diketik
                                            onChanged: (String? value) {
                                              setState(() {
                                                _money_paid = int.parse(value!);
                                              });
                                            },
                                            // Menambahkan behavior saat data disimpan
                                            onSaved: (String? value) {
                                              setState(() {
                                                _money_paid = int.parse(value!);
                                              });
                                            },
                                            // Validator sebagai validasi form
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Cash cannot be empty!';
                                              }
                                              return null;
                                            },
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      _bill = snapshot
                                                          .data![index]
                                                          .fields
                                                          .bill
                                                          .toString();
                                                      paymentMethod(_bill);
                                                      if (_berhasil) {
                                                        await paymentBill(
                                                            snapshot
                                                                .data![index]
                                                                .pk);
                                                        Navigator.pop(context);
                                                        refreshWidget();
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          'Success'),
                                                                      content: Text(
                                                                          'Kembalian: $_kembalian'),
                                                                    ));
                                                        // ignore: use_build_context_synchronously
                                                      } else {
                                                        Navigator.pop(context);
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          'Failed'),
                                                                      content: Text(
                                                                          'Your payment was not successfully processed because it is less than the price'),
                                                                    ));
                                                      }
                                                    },
                                                    child: Text("Submit")),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Close")),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.payment,
                                          color: Colors.white,
                                        ), // <-- Icon
                                        Text(
                                          "Payment",
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ), // <-- Text
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Patient: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.data![index].fields.patient,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Doctor: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.data![index].fields.doctor,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Bill: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.data![index].fields.bill
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Visibility(
                            visible: request.loggedIn,
                            child: SizedBox.fromSize(
                              size: Size(60, 60),
                              child: ClipOval(
                                child: Material(
                                  color: Colors.black,
                                  child: InkWell(
                                    splashColor: Colors.green,
                                    onTap: () async {
                                      await deleteBill(
                                          snapshot.data![index].pk);
                                      // ignore: use_build_context_synchronously
                                      refreshWidget();
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.delete_forever,
                                          color: Colors.white,
                                        ), // <-- Icon
                                        Text(
                                          "Delete",
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ), // <-- Text
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ), // ignore: prefer_interpolation_to_compose_strings
                        )),
                  ),
                );
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
          if (request.loggedIn)
            SpeedDialChild(
              child: Icon(Icons.add),
              label: 'Create Bill',
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.7,
                      builder: (_, controller) => Container(
                        color: Colors.white,
                        child: Form(
                          key: _kasirFormKey,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Create Bill",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ]),
                              ),
                              Padding(
                                // Menggunakan padding sebesar 8 pixels
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Patient's Name",
                                    // Menambahkan icon agar lebih intuitif
                                    icon: const Icon(Icons.people),
                                    // Menambahkan circular border agar lebih rapi
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  // Menambahkan behavior saat nama diketik
                                  onChanged: (String? value) {
                                    setState(() {
                                      _patient = value!;
                                    });
                                  },
                                  // Menambahkan behavior saat data disimpan
                                  onSaved: (String? value) {
                                    setState(() {
                                      _patient = value!;
                                    });
                                  },
                                  // Validator sebagai validasi form
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Pantient\'s name cannot be empty!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                // Menggunakan padding sebesar 8 pixels
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Doctor's Name",
                                    // Menambahkan icon agar lebih intuitif
                                    icon: const Icon(Icons.people_alt_outlined),
                                    // Menambahkan circular border agar lebih rapi
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  // Menambahkan behavior saat nama diketik
                                  onChanged: (String? value) {
                                    setState(() {
                                      _doctor = value!;
                                    });
                                  },
                                  // Menambahkan behavior saat data disimpan
                                  onSaved: (String? value) {
                                    setState(() {
                                      _doctor = value!;
                                    });
                                  },
                                  // Validator sebagai validasi form
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Doctor\'s name cannot be empty!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                // Menggunakan padding sebesar 8 pixels
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Description",
                                    // Menambahkan icon agar lebih intuitif
                                    icon: const Icon(Icons.description),
                                    // Menambahkan circular border agar lebih rapi
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  // Menambahkan behavior saat nama diketik
                                  onChanged: (String? value) {
                                    setState(() {
                                      _description = value!;
                                    });
                                  },
                                  // Menambahkan behavior saat data disimpan
                                  onSaved: (String? value) {
                                    setState(() {
                                      _description = value!;
                                    });
                                  },
                                  // Validator sebagai validasi form
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Description cannot be empty!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                // Menggunakan padding sebesar 8 pixels
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "Bill",
                                    // Menambahkan icon agar lebih intuitif
                                    icon: const Icon(Icons.people),
                                    // Menambahkan circular border agar lebih rapi
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  // Menambahkan behavior saat nama diketik
                                  onChanged: (String? value) {
                                    setState(() {
                                      _bill = value!;
                                    });
                                  },
                                  // Menambahkan behavior saat data disimpan
                                  onSaved: (String? value) {
                                    setState(() {
                                      _bill = value!;
                                    });
                                  },
                                  // Validator sebagai validasi form
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Bill cannot be empty!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      child: const Text('Submit'),
                                      onPressed: () async {
                                        if (_kasirFormKey.currentState!
                                            .validate()) {
                                          await request.post(
                                              "https://medstem.up.railway.app/kasir/add/",
                                              {
                                                "patient": _patient,
                                                "doctor": _doctor,
                                                "description": _description,
                                                "bill": _bill,
                                              }).then(
                                              (value) => {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          elevation: 15,
                                                          child: ListView(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20,
                                                                    bottom: 20),
                                                            shrinkWrap: true,
                                                            children: <Widget>[
                                                              const Center(
                                                                  child: Text(
                                                                      'bill has been created successfully')),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    Navigator.pop(context),
                                                    refreshWidget()
                                                  },
                                              onError: (error) => {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          elevation: 15,
                                                          child: ListView(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20,
                                                                    bottom: 20),
                                                            shrinkWrap: true,
                                                            children: <Widget>[
                                                              const Center(
                                                                  child: Text(
                                                                      'bill failed to generate')),
                                                              const SizedBox(
                                                                  height: 20),
                                                              TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child: const Text(
                                                                    'Kembali'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  });
                                        }
                                      }),
                                  ElevatedButton(
                                    child: const Text('Close'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
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
              refreshWidget();
            },
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods
    );
  }
}

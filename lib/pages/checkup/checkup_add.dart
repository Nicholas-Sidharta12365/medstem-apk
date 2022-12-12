import 'dart:convert';
import 'package:medstem/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/services.dart';

/* mengambil dari modul dan pages checkup */
import 'package:medstem/pages/checkup/checkup.dart';
import 'package:medstem/model/checkupmodel.dart';

class CheckupAddPage extends StatefulWidget {
  const CheckupAddPage({Key? key}) : super(key: key);

  @override
  _CheckupAddPageState createState() => _CheckupAddPageState();
}

class _CheckupAddPageState extends State<CheckupAddPage> {
  String name = '';
  DateTime date = DateTime(2015, 1, 1, 1); /*masih gatau buat apa */
  String doctor = '';
  String statusCheckupType = '';
  String recommendations = '';
  bool paid = false;
  TextEditingController dateInputController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(title: const Text('Add Checkup')),
        drawer: DrawerClass(),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        /* Nama Pasien */
                        Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: TextFormField(
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText: "Masukkan nama lengkap Anda",
                                  labelText: 'Nama Lengkap',
                                  icon: const Icon(Icons.people),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )),
                              onChanged: (String? value) {
                                setState(() {
                                  name = value!;
                                });
                              },
                              onSaved: (String? value) {
                                setState(() {
                                  name = value!;
                                });
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Nama tidak boleh kosong";
                                }
                                return null;
                              },
                            )),
                        /* DateTime */
                        Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: TextFormField(
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText: "Masukkan Tanggal Booking Anda",
                                  labelText: 'Date',
                                  icon: const Icon(Icons.date_range_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )),
                              controller: dateInputController,
                              readOnly: true,
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime(2025));
                                if (date != null) {
                                  dateInputController.text = date.toString();
                                }
                              },
                            )),
                        // Nama Doktor //
                        Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Masukkan nama Doktor Pesanan Anda",
                                  labelText: 'Doctor',
                                  icon:
                                      const Icon(Icons.people_outline_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )),
                              onChanged: (String? value) {
                                setState(() {
                                  doctor = value!;
                                });
                              },
                              onSaved: (String? value) {
                                setState(() {
                                  doctor = value!;
                                });
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Nama Doktor tidak boleh kosong";
                                }
                                return null;
                              },
                            )),
                        // status
                        Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    labelText: "Status Checkup",
                                    icon: const Icon(Icons.menu),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    )),
                                value: statusCheckupType,
                                items: const [
                                  DropdownMenuItem<String>(
                                      child: Text('-Pilih Status Checkup-'),
                                      value: ''),
                                  DropdownMenuItem<String>(
                                      child: Text('Masih Menunggu'),
                                      value: 'Tunggu'),
                                  DropdownMenuItem<String>(
                                      child: Text('Mengeluarkan Diri'),
                                      value: 'Keluar'),
                                  DropdownMenuItem<String>(
                                      child: Text('Pemeriksaan'),
                                      value: 'Periksa'),
                                  DropdownMenuItem<String>(
                                      child: Text('Menunggu Obat'),
                                      value: 'Obat'),
                                  DropdownMenuItem<String>(
                                      child: Text('Selesai Berobat'),
                                      value: 'Selesai'),
                                ],
                                onChanged: (String? value) {
                                  setState(() {
                                    statusCheckupType = value!;
                                  });
                                },
                                validator: (value) {
                                  if (statusCheckupType == '')
                                    return 'Kamu Harus Memilih Status Ini';
                                  return null;
                                })),
                        // rekomendasi //
                        Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Masukkan Rekomendasi",
                                  labelText: 'Recommendation',
                                  icon: const Icon(Icons.recommend),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )),
                              onChanged: (String? value) {
                                setState(() {
                                  recommendations = value!;
                                });
                              },
                              onSaved: (String? value) {
                                setState(() {
                                  recommendations = value!;
                                });
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Nama Doktor tidak boleh kosong";
                                }
                                return null;
                              },
                            )),
                        // CheckBox
                        CheckboxListTile(
                            title: Text("Paid"),
                            subtitle: Text("Harap Melakukan Pembayaran"),
                            value: paid,
                            activeColor: Colors.deepPurpleAccent,
                            onChanged: (value) {
                              setState(() {
                                paid = value!;
                              });
                            }),
                        TextButton(
                          child: const Text(
                            "Simpan",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await request.post(
                                  'https://medstem.up.railway.app/checkup/flutter-add/',
                                  jsonEncode(<String, String>{
                                    'name': name,
                                    'date': date.toString(),
                                    'doctor': doctor,
                                    'status_checkup_type': statusCheckupType,
                                    'recommendations': recommendations,
                                    'paid': paid.toString(),
                                  }));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CheckupPage(title: 'Checkup')));
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
                                  });
                            }
                          },
                        ),
                      ],
                    )))));
  }
}

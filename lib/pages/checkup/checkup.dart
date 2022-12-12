/* importing */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medstem/model/checkupmodel.dart';
import 'package:medstem/pages/checkup/checkup_add.dart';
import 'package:medstem/pages/checkup/detail_info.dart';
import 'package:medstem/utils/checkup_remote_data.dart';
import 'package:medstem/widgets/drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CheckUpStateless extends StatelessWidget {
  const CheckUpStateless({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medstem',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const CheckupPage(title: 'Checkup'),
    );
  }
}

class CheckupPage extends StatefulWidget {
  const CheckupPage({super.key, required this.title});
  final String title;

  @override
  State<CheckupPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CheckupPage> {
  @override
  Widget build(BuildContext context) {
    final request = Provider.of<CookieRequest>(
      context,
      listen: false,
    );
    CheckUpRemoteData dataSource = CheckUpRemoteData();

    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Image.asset(
            'assets/med_logo.png',
            height: 30,
            width: 30,
          ),
          Padding(padding: const EdgeInsets.all(5)),
          Text('Checkup'),
        ],
      )),
      drawer: const DrawerClass(),
      body: FutureBuilder(
          future: dataSource.fetchCheckUp(request),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              print('objext');
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data.length == 0) {
                return Column(
                  children: const [
                    Text(
                      "Belum ada Data Checkup",
                      style: TextStyle(fontSize: 20.0, color: Colors.purple),
                    ),
                    SizedBox(height: 7.0),
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Checkup info = snapshot.data![index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: const [
                              BoxShadow(color: Colors.black, blurRadius: 2.0)
                            ]),
                        child: ListTile(
                          title: Text(
                            info.name!,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: GestureDetector(
                            child: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailInfoCheckUp(checkup: info)));
                            },
                          ),
                        ),
                      );
                    });
              }
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CheckupAddPage()));
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

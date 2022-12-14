import 'package:flutter/material.dart';
import 'package:medstem/model/childcaremodel.dart';
import 'package:medstem/widgets/drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'enqueue.dart';

class Childcare extends StatelessWidget {
  const Childcare({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedStem',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const ChildcarePage(title: 'Childcare'),
    );
  }
}

class ChildcarePage extends StatefulWidget {
  const ChildcarePage({super.key, required this.title});

  final String title;

  @override
  State<ChildcarePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChildcarePage> {
  Future<List<ChildcareModel>> fetchChildcareData(CookieRequest request) async {
    // decode the response into the json form

    var data =
        await request.get('https://medstem.up.railway.app/childcare/json/');
    // convert the json data into VaccineData object
    List<ChildcareModel> listVaccineData = [];
    for (var d in data) {
      if (d != null) {
        listVaccineData.add(ChildcareModel.fromJson(d));
      }
    }

    return listVaccineData;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    bool status = request.loggedIn;

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
            child: Center(
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'CHILD',
                      style: TextStyle(
                        color: Color.fromARGB(255, 230, 48, 35),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'CARE',
                      style: TextStyle(
                        color: Color.fromARGB(255, 12, 112, 195),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
              "Our childcare service provides your child with the most competent doctors and up to date medicines and vaccines. In our service, your child is at the top of our priority and we will make sure you and your child will get the best service from our staffs. We also provided a small playground so that your child will not get bored while waiting in queue. Any further questions can be asked through our staffs or through our email at medstem_childcare@this.is.not.real.com.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          if(status)...[
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('Enqueue'),
                  onPressed: () {
                    // Handle the enqueue button press here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EnqueueForm()),
                    );
                  },
                ),
              ],
            ),
          ),
          FutureBuilder(
              future: fetchChildcareData(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => DataTable(
                        columns: const [
                          DataColumn(label: Text('PATIENT NAME')),
                          DataColumn(label: Text('CHECK-IN DATE')),
                          DataColumn(label: Text('DOCTOR')),
                          DataColumn(label: Text('DESCRIPTION')),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(snapshot.data![index].fields.name)),
                            DataCell(Text(snapshot.data![index].fields.date)),
                            DataCell(Text(snapshot.data![index].fields.doctor)),
                            DataCell(
                                Text(snapshot.data![index].fields.description)),
                          ]),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      child: const Text(
                        "No Data Yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                }
              }),
          ]
          else...[
            Container(
              margin: const EdgeInsets.only(bottom: 40, top: 40),
              child: const Text(
                "Please Log In to See the Queue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

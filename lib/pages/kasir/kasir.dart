import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:medstem/widgets/drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Column(
          children: [
            
          ],
        ),
      ),
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

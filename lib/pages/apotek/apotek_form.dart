import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medstem/pages/apotek/apotek.dart';
import 'package:medstem/pages/apotek/meds_list.dart';
import '../../main.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  String _jeniskelamin = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();

  void _choosejeniskelamin(value) {
    setState(() {
      _jeniskelamin = value;
    });
  }

// ignore: non_constant_identifier_names
  void send_data() {
    showDialog(
        context: context,
        // ignore: unnecessary_new
        builder: (ctxt) => new AlertDialog(
            content: Container(
                height: 200.0,
                child: Column(
                  children: <Widget>[
                    Text("Patient Name: ${nameController.text}"),
                    Text("Patient Age: ${ageController.text}"),
                    Text("Diagnosis: ${diagnosisController.text}"),
                    Text("Sex: $_jeniskelamin"),
                    ElevatedButton(
                        child: new Text("OK"),
                        onPressed: () => Navigator.pop(context))
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Add Prescription'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Patient Name",
                      labelText: "Patient Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                      hintText: "Patient Age",
                      labelText: "Patient Age",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                TextField(
                  controller: diagnosisController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "Diagnosis",
                      labelText: "Diagnosis",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                RadioListTile(
                  value: "Wanita",
                  title: const Text("Wanita"),
                  groupValue: _jeniskelamin,
                  onChanged: (value) {
                    _choosejeniskelamin(value);
                  },
                  activeColor: Colors.red,
                ),
                RadioListTile(
                  value: "Pria",
                  title: const Text("Pria"),
                  groupValue: _jeniskelamin,
                  onChanged: (value) {
                    _choosejeniskelamin(value);
                  },
                  activeColor: Colors.red,
                ),
                ElevatedButton(
                    child: const Text("OK"),
                    onPressed: () {
                      send_data();
                    }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyMedicationPage(
              name: nameController.text,
              age: ageController.text,
              diagnosis: diagnosisController.text,
              sex: _jeniskelamin,
            )),
          );
        },
      ),
    );
  }
}

// class MedicationPage extends StatelessWidget {
//   const MedicationPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Second Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_select_all_list/data.dart';
//
// class MyMedicationPage extends StatefulWidget {
//   @override
//   _MedicationPageState createState() => _MedicationPageState();
// }
//
// class _MedicationPageState extends State<MyMedicationPage> {
//   List<Map> staticData = MyMedicineData.data;
//   Map<int, bool> selectedFlag = {};
//   bool isSelectionMode = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Item'),
//       ),
//       body: ListView.builder(
//         itemBuilder: (builder, index) {
//           Map data = staticData[index];
//           return ListTile(
//             title: Text("${data['name']}"),
//             subtitle: Text("${data['email']}"),
//             leading: CircleAvatar(
//               child: Text('${data['id']}'),
//             ),
//           );
//         },
//         itemCount: staticData.length,
//       ),
//     );
//   }
//   void onLongPress(bool isSelected, int index) {
//     setState(() {
//       selectedFlag[index] = !isSelected;
//       // If there will be any true in the selectionFlag then
//       // selection Mode will be true
//       isSelectionMode = selectedFlag.containsValue(true);
//     });
//   }
//
//   Widget _buildSelectIcon(bool isSelected, Map data) {
//     if (isSelectionMode) {
//       return Icon(
//         isSelected ? Icons.check_box : Icons.check_box_outline_blank,
//         color: Theme.of(context).primaryColor,
//       );
//     } else {
//       return CircleAvatar(
//         child: Text('${data['id']}'),
//       );
//     }
//   }
//   void onTap(bool isSelected, int index) {
//     if (isSelectionMode) {
//       setState(() {
//         selectedFlag[index] = !isSelected;
//         isSelectionMode = selectedFlag.containsValue(true);
//       });
//     } else {
//       // Open Detail Page
//     }
//   }
// }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_select_all_list/data.dart';

class MyMedicationPage extends StatefulWidget {
  final String name;
  final String age;
  final String diagnosis;
  final String sex;

  const MyMedicationPage({
    super.key,
    required this.name,
    required this.age,
    required this.diagnosis,
    required this.sex,
  });

  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MyMedicationPage> {
  List<Map> staticData = MyMedicineData.data;
  Map<int, bool> selectedFlag = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Medications'),
      ),
      body: ListView.builder(
        itemBuilder: (builder, index) {
          Map data = staticData[index];
          selectedFlag[index] = selectedFlag[index] ?? false;
          bool isSelected = selectedFlag[index]!;

          return ListTile(
            onTap: () => onTap(isSelected, index),
            title: Text("${data['name']}"),
            subtitle: Text("${data['email']}"),
            leading: _buildSelectIcon(isSelected, data),
          );
        },
        itemCount: staticData.length,
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Container(
                    height: 200.0,
                    child: Column(
                      children: <Widget>[
                        Text("Patient Name: ${widget.name}"),
                        Text("Patient Age: ${widget.age}"),
                        Text("Diagnosis: ${widget.diagnosis}"),
                        Text("Sex: ${widget.sex}"),
                        Text("Prescription: "),
                        Column(
                          children: List.generate(staticData.length, (index) {
                            if (selectedFlag[index] == true) {
                              return Text(staticData[index]['name']);
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                        ),
                        ElevatedButton(
                            child: new Text("OK"),
                            onPressed: () => Navigator.pop(context))
                      ],
                    )),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    ); // floatingActionButton: _buildSelectAllButton(),
  }

  void onTap(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
    });
  }

  Widget _buildSelectIcon(bool isSelected, Map data) {
    return Icon(
      isSelected ? Icons.check_box : Icons.check_box_outline_blank,
      color: Theme.of(context).primaryColor,
    );
  }

// Widget? _buildSelectAllButton() {
//   bool isFalseAvailable = selectedFlag.containsValue(false);
//   if (isSelectionMode) {
//     return FloatingActionButton(
//       onPressed: _selectAll,
//       child: Icon(
//         isFalseAvailable ? Icons.done_all : Icons.remove_done,
//       ),
//     );
//   } else {
//     return null;
//   }
// }
//
// void _selectAll() {
//   bool isFalseAvailable = selectedFlag.containsValue(false);
//   // If false will be available then it will select all the checkbox
//   // If there will be no false then it will de-select all
//   selectedFlag.updateAll((key, value) => isFalseAvailable);
//   setState(() {
//     isSelectionMode = selectedFlag.containsValue(true);
//   });
// }

}

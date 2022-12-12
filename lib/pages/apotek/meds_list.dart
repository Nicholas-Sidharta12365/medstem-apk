import 'package:flutter/material.dart';
import '../../main.dart';
import 'apotek_form.dart';
import 'apotek.dart';

class MyMedicineData {
  static List<Map> data = [
    {
      "id": 1,
      "name": "Sanmol Tablet",
      "detail": "500 mg 4 tablet/strip",
    },
    {
      "id": 2,
      "name": "Sanmol Sirup",
      "detail": "Sirup 60 ml/botol",
    },
    {
      "id": 3,
      "name": "Panadol Blue",
      "detail": "500 mg 10 kaplet/strip",
    },
    {
      "id": 4,
      "name": "Prosis Kaplet",
      "detail": "200 mg 10 kaplet/strip",
    },
    {
      "id": 5,
      "name": "Ibuprofen Tablet",
      "detail": "400 mg 10 tablet/strip",
    },
    {
      "id": 6,
      "name": "Tempra Sirup",
      "detail": "Sirup 60 ml/botol",
    },
    {
      "id": 7,
      "name": "Panadol Anak",
      "detail": "120 mg 10 tablet kunyah/strip",
    },
    // anti inflamasi
    {
      "id": 8,
      "name": "Toras",
      "detail": "8 mg 10 tablet/strip",
    },
    {
      "id": 9,
      "name": "Dexa-M",
      "detail": "0.75 mg 10 tablet/strip",
    },
    {
      "id": 10,
      "name": "Dexaharsen",
      "detail": "0.5 mg 10 kaplet/strip",
    },
    {
      "id": 11,
      "name": "Methylprednisolone",
      "detail": "8 mg 10 tablet/strip",
    },
    // pencernaan
    {
      "id": 12,
      "name": "Polysilane",
      "detail": "8 tablet/strip",
    },
    {
      "id": 13,
      "name": "Ondansetron",
      "detail": "4 mg 6 tablet/strip",
    },
    {
      "id": 14,
      "name": "Episan Suspensi",
      "detail": "100 ml/botol",
    },
    // batuk flu
    {
      "id": 15,
      "name": "Panadol Cold & Flu",
      "detail": "10 kaplet/strip",
    },
    {
      "id": 16,
      "name": "Intunal F",
      "detail": "10 tablet/strip",
    },
    {
      "id": 17,
      "name": "Tremenza",
      "detail": "10 tablet/strip",
    },
    // vitamin dan suplemen
    {
      "id": 18,
      "name": "Sangobion",
      "detail": "10 kapsul/strip",
    },
    {
      "id": 19,
      "name": "Imboost Force",
      "detail": "10 kaplet/strip",
    },
    {
      "id": 20,
      "name": "Becom-Zet",
      "detail": "10 kaplet/strip",
    },
  ];
}
class MyMedicationListPage extends StatefulWidget {

  const MyMedicationListPage({
    super.key,
  });

  @override
  _MedicationListPageState createState() => _MedicationListPageState();
}

class _MedicationListPageState extends State<MyMedicationListPage> {
  List<Map> staticData = MyMedicineData.data;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication List'),
      ),
      body: ListView.builder(
        itemBuilder: (builder, index) {
          Map data = staticData[index];

          return ListTile(
            title: Text("${data['name']}"),
            subtitle: Text("${data['detail']}"),
          );
        },
        itemCount: staticData.length,
      ),
    ); // floatingActionButton: _buildSelectAllButton(),
  }
}

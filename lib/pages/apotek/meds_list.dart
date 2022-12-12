import 'package:flutter/material.dart';
import '../../main.dart';
import 'apotek_form.dart';
import 'apotek.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),2
//     );
//   }
// }

// // class MyFormPage extends StatefulWidget {
// //   const MyFormPage({super.key});

// //   @override
// //   State<MyFormPage> createState() => _MyFormPageState();
// // }


// class MyMedsListPage extends StatefulWidget {
//   const MyMedsListPage{super.key;});
//   @override
//   State<MyMedsListPage> createState() => _MyMedsListState();
// }

// class _MyMedsListState extends State<MyHomePage> {
//   late String _selected;
//   final List<Map> _myJson = [
//     {"id": '1', "image": "assets/banks/affinbank.png", "name": "Affin Bank"},
//     {"id": '2', "image": "assets/banks/ambank.png", "name": "Ambank"},
//     {"id": '3', "image": "assets/banks/bankislam.png", "name": "Bank Isalm"},
//     {"id": '4', "image": "assets/banks/bankrakyat.png", "name": "Bank Rakyat"},
//     {
//       "id": '5',
//       "image": "assets/banks/bsn.png",
//       "name": "Bank Simpanan Nasional"
//     },
//     {"id": '6', "image": "assets/banks/cimb.png", "name": "CIMB Bank"},
//     {
//       "id": '7',
//       "image": "assets/banks/hong-leong-connect.png",
//       "name": "Hong Leong Bank"
//     },
//     {"id": '8', "image": "assets/banks/hsbc.png", "name": "HSBC"},
//     {"id": '9', "image": "assets/banks/maybank.png", "name": "MayBank2U"},
//     {
//       "id": '10',
//       "image": "assets/banks/public-bank.png",
//       "name": "Public Bank"
//     },
//     {"id": '11', "image": "assets/banks/rhb-now.png", "name": "RHB NOW"},
//     {
//       "id": '12',
//       "image": "assets/banks/standardchartered.png",
//       "name": "Standard Chartered"
//     },
//     {
//       "id": '13',
//       "image": "assets/banks/uob.png",
//       "name": "United Oversea Bank"
//     },
//     {"id": '14', "image": "assets/banks/ocbc.png", "name": "OCBC Bank"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bank Demo App'),
//       ),
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(15),
//           decoration: BoxDecoration(
//               border: Border.all(width: 1, color: Colors.grey),
//               borderRadius: BorderRadius.circular(10)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Expanded(
//                 child: DropdownButtonHideUnderline(
//                   child: ButtonTheme(
//                     alignedDropdown: true,
//                     child: DropdownButton<String>(
//                       isDense: true,
//                       hint: new Text("Select Bank"),
//                       value: _selected,
//                       onChanged: (String newValue) {
//                         setState(() {
//                           _selected = newValue;
//                         });

//                       },
//                       items: _myJson.map((Map map) {
//                         return new DropdownMenuItem<String>(
//                           value: map["id"].toString(),
//                           // value: _mySelection,
//                           child: Row(
//                             children: <Widget>[
//                               Image.asset(
//                                 map["image"],
//                                 width: 25,
//                               ),
//                               Container(
//                                   margin: EdgeInsets.only(left: 10),
//                                   child: Text(map["name"])),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class MyMedicineData {
  static List<Map> data = [
    {
      "id": 1,
      "name": "Sanmol Tablet",
      "email": "500 mg 4 tablet/strip",
      "address": "57 Bowman Drive"
    },
    {
      "id": 2,
      "name": "Sanmol Sirup",
      "email": "Sirup 60 ml/botol",
      "address": "2171 Welch Avenue"
    },
    {
      "id": 3,
      "name": "Panadol Blue",
      "email": "500 mg 10 kaplet/strip",
      "address": "4623 Chinook Circle"
    },
    {
      "id": 4,
      "name": "Prosis Kaplet",
      "email": "200 mg 10 kaplet/strip",
      "address": "406 Kings Road"
    },
    {
      "id": 5,
      "name": "Ibuprofen Tablet",
      "email": "400 mg 10 tablet/strip",
      "address": "2444 Pawling Lane"
    },
    {
      "id": 6,
      "name": "Tempra Sirup",
      "email": "Sirup 60 ml/botol",
      "address": "2444 Pawling Lane"
    },
    {
      "id": 7,
      "name": "Panadol Anak",
      "email": "120 mg 10 tablet kunyah/strip",
      "address": "2444 Pawling Lane"
    },
    // anti inflamasi
    {
      "id": 8,
      "name": "Toras",
      "email": "8 mg 10 tablet/strip",
      "address": "2444 Pawling Lane"
    },
    {
      "id": 9,
      "name": "Dexa-M",
      "email": "0.75 mg 10 tablet/strip",
      "address": "2444 Pawling Lane"
    },
    {
      "id": 10,
      "name": "Dexaharsen",
      "email": "0.5 mg 10 kaplet/strip",
      "address": "2444 Pawling Lane"
    },
    {
      "id": 11,
      "name": "Methylprednisolone",
      "email": "8 mg 10 tablet/strip",
      "address": "2444 Pawling Lane"
    },
    // pencernaan
    {
      "id": 12,
      "name": "Polysilane",
      "email": "8 tablet/strip",
      "address": "2444 Pawling Lane"
    },
    {
      "id": 13,
      "name": "Ondansetron",
      "email": "4 mg 6 tablet/strip",
      "address": "2444 Pawling Lane"
    },
    {
      "id": 14,
      "name": "Episan Suspensi",
      "email": "100 ml/botol",
      "address": "2444 Pawling Lane"
    },
    // batuk flu
    {
      "id": 15,
      "name": "Panadol Cold & Flu",
      "email": "10 kaplet/strip",
      "address": "2444 Pawling Lane"
    },
    {
      "id": 16,
      "name": "Intunal F",
      "email": "10 tablet/strip",
      "address": "2444 Pawling Lane"
    },
    {
      "id": 17,
      "name": "Tremenza",
      "email": "10 tablet/strip",
      "address": "2444 Pawling Lane"
    },
    // vitamin dan suplemen
    {
      "id": 18,
      "name": "Sangobion",
      "email": "10 kapsul/strip",
      "address": "2444 Pawling Lane"
    },
    {
      "id": 19,
      "name": "Imboost Force",
      "email": "10 kaplet/strip",
      "address": "2444 Pawling Lane"
    },
    {
      "id": 20,
      "name": "Becom-Zet",
      "email": "10 kaplet/strip",
      "address": "2444 Pawling Lane"
    },
  ];
}
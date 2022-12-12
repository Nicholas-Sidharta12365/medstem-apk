import 'package:medstem/model/kasir_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Chasier>> fetchChasier() async {
  var url = Uri.parse('https://medstem.up.railway.app/kasir/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Bmi
  List<Chasier> listMyChasier = [];
  for (var d in data) {
    if (d != null) {
      listMyChasier.add(Chasier.fromJson(d));
    }
  }

  return listMyChasier;
}
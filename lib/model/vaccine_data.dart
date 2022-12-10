// To parse this JSON data, do
//
//     final vaccineData = vaccineDataFromJson(jsonString);

import 'dart:convert';

List<VaccineData> vaccineDataFromJson(String str) => List<VaccineData>.from(json.decode(str).map((x) => VaccineData.fromJson(x)));

String vaccineDataToJson(List<VaccineData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VaccineData {
    VaccineData({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory VaccineData.fromJson(Map<String, dynamic> json) => VaccineData(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        required this.user,
        required this.date,
        required this.name,
        required this.sideEffect,
        required this.dose,
        required this.stock,
    });

    int user;
    DateTime date;
    String name;
    String sideEffect;
    double dose;
    int stock;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
        sideEffect: json["side_effect"],
        dose: json["dose"].toDouble(),
        stock: json["stock"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "name": name,
        "side_effect": sideEffect,
        "dose": dose,
        "stock": stock,
    };
}

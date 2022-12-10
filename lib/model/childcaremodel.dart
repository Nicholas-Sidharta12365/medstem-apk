// To parse this JSON data, do
//
//     final childcareModel = childcareModelFromJson(jsonString);

import 'dart:convert';

ChildcareModel childcareModelFromJson(String str) => ChildcareModel.fromJson(json.decode(str));

String childcareModelToJson(ChildcareModel data) => json.encode(data.toJson());

class ChildcareModel {
    ChildcareModel({
        required this.name,
        required this.date,
        required this.doctor,
        required this.description,
    });

    String name;
    DateTime date;
    String doctor;
    String description;

    factory ChildcareModel.fromJson(Map<String, dynamic> json) => ChildcareModel(
        name: json["name"],
        date: DateTime.parse(json["date"]),
        doctor: json["doctor"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "doctor": doctor,
        "description": description,
    };
}

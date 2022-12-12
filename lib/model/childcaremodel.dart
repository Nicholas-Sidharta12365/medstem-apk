// To parse this JSON data, do
//
//     final childcareModel = childcareModelFromJson(jsonString);

import 'dart:convert';

List<ChildcareModel> childcareModelFromJson(String str) => List<ChildcareModel>.from(json.decode(str).map((x) => ChildcareModel.fromJson(x)));

String childcareModelToJson(List<ChildcareModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChildcareModel {
    ChildcareModel({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory ChildcareModel.fromJson(Map<String, dynamic> json) => ChildcareModel(
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
        required this.name,
        required this.date,
        required this.doctor,
        required this.description,
    });

    String name;
    String date;
    String doctor;
    String description;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        date: json["date"],
        doctor: json["doctor"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
        "doctor": doctor,
        "description": description,
    };
}

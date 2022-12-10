// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    Welcome({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
        required this.doctor,
        required this.patient,
        required this.patientStatusPayment,
        required this.description,
        required this.bill,
    });

    int user;
    DateTime date;
    String doctor;
    String patient;
    bool patientStatusPayment;
    String description;
    int bill;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        date: DateTime.parse(json["date"]),
        doctor: json["doctor"],
        patient: json["patient"],
        patientStatusPayment: json["patient_status_payment"],
        description: json["description"],
        bill: json["bill"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "doctor": doctor,
        "patient": patient,
        "patient_status_payment": patientStatusPayment,
        "description": description,
        "bill": bill,
    };
}

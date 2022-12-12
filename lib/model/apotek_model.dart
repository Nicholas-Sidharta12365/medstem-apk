// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// To parse this JSON data, do
//
//     final chasier = chasierFromJson(jsonString);

import 'dart:convert';

PatientData patientDataFromJson(String str) => PatientData.fromJson(json.decode(str));

//String patientDataToJson(PatientData data) => json.encode(data.toJson());



// List<PatientData> patientDataFromJson(String str) => List<PatientData>.from(json.decode(str).map((x) => PatientData.fromJson(x)));

// String patientDataToJson(List<PatientData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientData {
    PatientData({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    /*Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };*/
}

class Fields {
    Fields({
        required this.user,
        required this.patient_name,
        required this.patient_age,
        required this.patient_gender,
        required this.medicine,
        // required this.
    });

    int user;
    String patient_name;
    int patient_age;
    String patient_gender;
    String medicine;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        patient_name: json["patient_name"],
        patient_age: json["patient_age"],
        patient_gender: json["patient_gender"],
        medicine: json["medicine"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "patient_name": patient_name,
        "patient_age": patient_age,
        "patient_gender": patient_gender,
        "medicine": medicine,
    };
}


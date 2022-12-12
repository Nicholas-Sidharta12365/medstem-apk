class Checkup {
  int? user;
  String? name;
  String? date;
  String? doctor;
  String? statusCheckupType;
  String? recommendations;
  bool? paid;

  Checkup(
      {this.user,
      this.name,
      this.date,
      this.doctor,
      this.statusCheckupType,
      this.recommendations,
      this.paid});

  Checkup.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    name = json['name'];
    date = json['date'];
    doctor = json['doctor'];
    statusCheckupType = json['status_checkup_type'];
    recommendations = json['recommendations'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = user;
    data['name'] = name;
    data['date'] = date;
    data['doctor'] = doctor;
    data['status_checkup_type'] = statusCheckupType;
    data['recommendations'] = recommendations;
    data['paid'] = paid;
    return data;
  }
}

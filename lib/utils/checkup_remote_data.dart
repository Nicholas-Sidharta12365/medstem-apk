import 'package:medstem/model/checkupmodel.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:async';

class CheckUpRemoteData {
  Future<List<Checkup>> fetchCheckUp(CookieRequest request) async {
    try {
      final List<Checkup> result = [];
      final response = await request
          .get('https://medstem.up.railway.app/checkup/refresh-json/');
      for (var item in response) {
        Checkup post = Checkup.fromJson(item['fields']);
        result.add(post);
      }
      return result.toList();
    } catch (e) {
      throw Exception('error: $e');
    }
  }
}

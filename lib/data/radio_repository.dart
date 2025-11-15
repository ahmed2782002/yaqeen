import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/radiosModel.dart';

class RadioRepository {
  Future<List<Radios>> getRadios() async {
    final url = Uri.https("mp3quran.net", "/api/v3/radios");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final radiosModel = RadiosModel.fromJson(jsonDecode(response.body));
      return radiosModel.radios ?? [];
    } else {
      throw Exception("فشل تحميل البيانات: ${response.statusCode}");
    }
  }
}

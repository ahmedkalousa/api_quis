import 'dart:convert';

import 'package:http/http.dart' as http;

class Network {
  Future<String> fetchImage() async {
    var data;
    http.Response response = await http.get(
      Uri.parse(
          'https://random.imagecdn.app/v1/image?category=city&format=json'),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data['url'];
    }
    return Future.error('error');
  }

  Future<Map<String, dynamic>> fetchData() async {
    var data;

    http.Response response = await http.get(
      Uri.parse('https://api.quotable.io/random'),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    }
    return Future.error('error');
  }
}

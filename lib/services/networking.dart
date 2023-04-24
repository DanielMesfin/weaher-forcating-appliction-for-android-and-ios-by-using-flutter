import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkHelper {
  var url;
  NetworkHelper({required this.url});
  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:skinhelpdesk_app/config/skinhelpdesk_config.dart';

class APIService {
  // API key
  String _api_key = skinhelpdeskConfig['apikey'] ?? "";
  // Base API url
  String _baseUrl = skinhelpdeskConfig['shdurl'] ?? "";
  // String _service = skinhelpdeskConfig['service'] ?? "";


  // Base API request to get response
  Future<Map<String, dynamic>> post({
    required String endpoint,
    required String query,
  }) async {

    // Base headers for Response url
    Map<String, String> _headers = {
      "content-type": "application/json",
      "x-rapidapi-host": "skinhelpdesk.p.rapidapi.com",
      "x-rapidapi-key": this._api_key,
    };
    Uri uri = Uri.https("https://" + _baseUrl, endpoint);

    final response = await http.post(uri,
        headers: _headers,
        body: jsonEncode(query));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
    }
  }
}

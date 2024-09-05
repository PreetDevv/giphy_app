import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qt_giphy_test_preet/Constants/ConstantFunctions.dart';
import 'package:qt_giphy_test_preet/Constants/ConstantString.dart';
import 'package:qt_giphy_test_preet/Support/Progressbar.dart';

class ApiService {


  static Future<Map<String, dynamic>?> fetchGifs({
    String query = 'dance',
    int limit = 20,
    int offset = 0,
    String rating = 'g',
    String lang = 'en',
    String bundle = 'messaging_non_clips',
  }) async {
    final Uri url = Uri.parse(
        '${ConstantString.searchUrl}?api_key=${ConstantString.apiKey}&q=$query&limit=$limit&offset=$offset&rating=$rating&lang=$lang&bundle=$bundle');

    try {

      final response = await http.get(url);

      Progressbar.dismissProgressbar();

      if (response.statusCode == 200) {
        // Decode the response body as JSON
        return jsonDecode(response.body);
      } else {
        print('Failed to load gifs: ${response.statusCode}');
        
        return null;
      }
    } catch (e) {
      Progressbar.dismissProgressbar();

      print('Error fetching gifs: $e');
      return null;
    }
  }


  static Future<Map<String, dynamic>?> fetchTrendingGifs({
    int limit = 20,
    int offset = 0,
    String rating = 'g',
    String bundle = 'messaging_non_clips',
  }) async {

    Progressbar.showProgressbar();

    final Uri url = Uri.parse(
        '${ConstantString.trendingUrl}?api_key=${ConstantString.apiKey}&limit=$limit&offset=$offset&rating=$rating&bundle=$bundle');

    try {


      final response = await http.get(url);

      Progressbar.dismissProgressbar();
      if (response.statusCode == 200) {
        // Decode the response body as JSON

        return json.decode(response.body);
      } else {
        print('Failed to load trending gifs: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      Progressbar.dismissProgressbar();

      print('Error fetching trending gifs: $e');
      return null;
    }
  }
}

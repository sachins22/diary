import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://192.168.29.125:1922/api'; // Replace with your backend's base URL

  static Future<List<dynamic>> getAllEntries() async {
    final response = await http.get(Uri.parse('$baseUrl/Gentries'));
    // print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData['data'] as List<dynamic>;
    } else {
      throw Exception('Failed to load entries');
    }
  }

  static Future<Map<String, dynamic>> getEntryById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/Gentries/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load entry');
    }
  }

  static Future<void> createEntry(Map<String, dynamic> entry) async {
    final response = await http.post(
      Uri.parse('$baseUrl/entries'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(entry),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create entry');
    }
  }

  static Future<void> updateEntry(
      String id, Map<String, dynamic> updatedEntry) async {
    final response = await http.put(
      Uri.parse('$baseUrl/Pentries/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedEntry),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update entry');
    }
  }

  static Future<void> deleteEntry(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/Dentries/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete entry');
    }
  }
}

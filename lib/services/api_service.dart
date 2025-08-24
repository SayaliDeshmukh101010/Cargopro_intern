import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cargopro_intern_app/data/models/object_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.restful-api.dev/objects';

  // Get all objects
  static Future<List<ApiObject>> getObjects() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ApiObject.fromJson(json)).toList();
      } else {
        throw 'Failed to load objects: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load objects: $e';
    }
  }

  // Get single object by ID
  static Future<ApiObject> getObject(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      
      if (response.statusCode == 200) {
        return ApiObject.fromJson(json.decode(response.body));
      } else {
        throw 'Failed to load object: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load object: $e';
    }
  }

  // Create new object
  static Future<ApiObject> createObject(ApiObject object) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(object.toJson()),
      );
      
      if (response.statusCode == 200) {
        return ApiObject.fromJson(json.decode(response.body));
      } else {
        throw 'Failed to create object: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to create object: $e';
    }
  }

  // Update object
  static Future<ApiObject> updateObject(String id, ApiObject object) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(object.toJson()),
      );
      
      if (response.statusCode == 200) {
        return ApiObject.fromJson(json.decode(response.body));
      } else {
        throw 'Failed to update object: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to update object: $e';
    }
  }

  // Delete object
  static Future<void> deleteObject(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      
      if (response.statusCode != 200) {
        throw 'Failed to delete object: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to delete object: $e';
    }
  }
}
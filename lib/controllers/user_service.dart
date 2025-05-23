import 'package:flutter/foundation.dart';
import 'package:college_ecommerce_app/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = 'http://localhost:8181';

  Future<List<User>> readUsers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users'));
      if (response.statusCode == 200) {
        return usersFromJson(response.body);
      } else {
        if (kDebugMode) {
          print('Failed to read users: ${response.statusCode}');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error reading users: $e');
      }
      return [];
    }
  }

  Future<void> writeUsers(List<User> users) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: usersToJson(users),
      );
      if (response.statusCode != 200) {
        if (kDebugMode) {
          print('Failed to write users: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error writing users: $e');
      }
    }
  }

  Future<void> clearUsers() async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/users'));
      if (response.statusCode != 200) {
        if (kDebugMode) {
          print('Failed to clear users: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing users: $e');
      }
    }
  }
}

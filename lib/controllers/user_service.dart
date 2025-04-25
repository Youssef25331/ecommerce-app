import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:college_ecommerce_app/models/user.dart';

class UserService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/users.json');
  }

  Future<List<User>> readUsers() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return [];
      }
      final contents = await file.readAsString();
      return usersFromJson(contents);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading users: $e');
      }
      return [];
    }
  }

  Future<void> writeUsers(List<User> users) async {
    try {
      final file = await _localFile;
      final jsonString = usersToJson(users);
      await file.writeAsString(jsonString);
    } catch (e) {
      if (kDebugMode) {
        print('Error writing users: $e');
      }
    }
  }

  Future<void> clearUsers() async {
    try {
      final file = await _localFile;
      await file.writeAsString('[]');
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing users: $e');
      }
    }
  }
}

import 'dart:convert';
import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  late final List<String> wishlist;
  final List<String> cart;

  User({
    String? id,
    required this.name,
    required this.email,
    required this.password,
    required this.wishlist,
    required this.cart,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'wishlist': wishlist,
    'cart': cart,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String? ?? const Uuid().v4(),
    name: json['name'] as String? ?? 'johndoe',
    email: json['email'] as String? ?? 'johndoe@gmail.com',
    password: json['password'] as String? ?? '',
    wishlist: (json['wishlist'] as List<dynamic>?)?.cast<String>() ?? [],
    cart: (json['cart'] as List<dynamic>?)?.cast<String>() ?? [],
  );
}

List<User> usersFromJson(String jsonString) {
  try {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => User.fromJson(json)).toList();
  } catch (e) {
    print('Error parsing users JSON: $e');
    return [];
  }
}

String usersToJson(List<User> users) {
  return jsonEncode(users.map((user) => user.toJson()).toList());
}

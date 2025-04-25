import 'dart:convert';
import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String name;
  final String details;
  final String seller;
  final String price;
  final String imagePath;
  final String sellerProfile;
  final String sellerLocation;
  final String category;

  Product({
    String? id,
    required this.name,
    required this.details,
    required this.seller,
    required this.price,
    required this.imagePath,
    required this.sellerProfile,
    required this.sellerLocation,
    required this.category,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'seller': seller,
    'price': price,
    'details': details,
    'imagePath': imagePath,
    'sellerProfile': sellerProfile,
    'sellerLocation': sellerLocation,
    'category': category,
  };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as String,
    name: json['name'] as String,
    seller: json['seller'] as String,
    price: json['price'] as String,
    details: json['details'] as String,
    category: json['category'] as String,
    imagePath: json['imagePath'] as String,
    sellerLocation: json['sellerLocation'] as String,
    sellerProfile: json['sellerProfile'] as String,
  );
}

List<Product> productsFromJson(String jsonString) {
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((json) => Product.fromJson(json)).toList();
}

String productsToJson(List<Product> products) {
  return jsonEncode(products.map((product) => product.toJson()).toList());
}

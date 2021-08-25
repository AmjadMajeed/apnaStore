// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.allproducts,
  });

  List<Allproduct> allproducts;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    allproducts: List<Allproduct>.from(json["allproducts"].map((x) => Allproduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "allproducts": List<dynamic>.from(allproducts.map((x) => x.toJson())),
  };
}

class Allproduct {
  Allproduct({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.brand,
    required this.countInStock,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    // required this.averageRating,
  });

  String imageUrl;
  String id;
  String name;
  int price;
  String category;
  String brand;
  String countInStock;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  // int averageRating;

  factory Allproduct.fromJson(Map<String, dynamic> json) => Allproduct(
    imageUrl: json["imageUrl"],
    id: json["_id"],
    name: json["name"],
    price: json["price"],
    category: json["category"],
    brand: json["brand"],
    countInStock: json["countInStock"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    // averageRating: json["averageRating"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "_id": id,
    "name": name,
    "price": price,
    "category": category,
    "brand": brand,
    "countInStock": countInStock,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    // "averageRating": averageRating,
  };
}

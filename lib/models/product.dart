// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

enum CATEGORY {
  Handbags,
  Jewlleries,
  Footwear,
  Dresses,
}

// class Product {
//   final String? productID;
//   final String title;
//   final String catorgery;
//   final double price;
//   final String description;
//   final int quantity;
//   final String? size;
//   final Color? color;

//   Product({
//     this.productID,
//     required this.title,
//     required this.catorgery,
//     required this.price,
//     required this.description,
//     required this.quantity,
//     required this.color,
//     required this.size,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'productID': productID,
//       'title': title,
//       'catorgery': catorgery,
//       'price': price,
//       'description': description,
//       'quantity': quantity,
//       'size': size,
//       'color': color?.value,
//     };
//   }

//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       productID: map['_id'] != null ? map['productID'] as String : null,
//       title: map['title'] as String,
//       catorgery: map['catorgery'] as String,
//       price: map['price'] as double,
//       description: map['description'] as String,
//       quantity: map['quantity'] as int,
//       size: map['size'] != null ? map['size'] as String: null,
//       color: map['color'] != null ? Color(map['color'] as int) : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Product.fromJson(String source) =>
//       Product.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Product {
  final String title;
  final String description;
  final String category;
  final String size;
  final String id;
  final double price;
  final double averageRating;
  final List<String> images;
  // final Color color;
  final int quantity;

  Product({
    required this.category,
    required this.images,
    required this.title,
    required this.quantity,
    required this.description,
    required this.price,
    required this.size,
    required this.averageRating,
    required this.id,
    // required this.color,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'size': size,
      'id': id,
      'price': price,
      'images': images,
      // 'color': color.value,
      'quantity': quantity,
      'category': category,
      'averageRating': averageRating,
    };
  }

  // factory Product.fromMap(Map<String, dynamic> map) {
  //   return Product(
  //     title: map['title'] as String ?? '',
  //     description: map['description'] as String ?? '',
  //     size: map['size'] as String,
  //     id: map['_id'] as String ?? '',
  //     category: map['category'] as String ?? '',
  //     price: map['price' ?? 0] is int
  //         ? (map['price' ?? 0] as int).toDouble()
  //         : map['price' ?? 0] as double,
  //     images: List<String>.from(map['images'] as List<dynamic>) ?? [],
  //     // color: Color(map['color'] as int),
  //     quantity: map['quantity' ?? 0] as int,
  //   );
  // }
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'] as String? ?? '', // Handle null values
      description: map['description'] as String? ?? '', // Handle null values
      size: map['size'] as String? ?? '', // Handle null values
      id: map['_id'] as String? ?? '', // Handle null values
      // category: map['category'] as String? ?? '', // Handle null values
      // price:map['price'] as double ??
      //     0.0, // Handle null values
      price: map['price'] != null
          ? (map['price'] is String
              ? double.tryParse(map['price'] as String) ?? 0.0
              : (map['price'] as double))
          : 0.0, // Handle null values
      averageRating: map['averageRating'] != null
          ? (map['averageRating'] is int
              ? (map['averageRating'] as int).toDouble()
              : (map['averageRating'] as double))
          : 0.0,

      // averageRating: map['averageRating'] != null
      //     ? (map['averageRating'] is int
      //         ? map['averageRating'] as double ?? 0.0
      //         : (map['averageRating'] as double))
      //     : 0.0, // Handle null values
      // averageRating:
      //     map['averageRating'] as double ?? 0.0, // Handle null values
      images: List<String>.from(
          map['images'] as List<dynamic>? ?? []), // Handle null values
      quantity: map['quantity'] as int? ?? 0,
      category: map['category'] as String? ?? '', // Handle null values
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

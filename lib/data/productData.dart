// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/material.dart';

// class Product {
//   final String title;
//   final String description;
//   final String  size;
//   final String  id;
//   final double price;
//   final List<String> images;
import 'package:online_shopping_store/models/product.dart';

// final Color color;
//   final int quantity;

//   Product(
//       {
//       required this.images,
//       required this.title,
//       required this.quantity,
//       required this.description,
//       required this.price,
//       required this.size,
//       required this.id,
//       required this.color
//       });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'title': title,
//       'description': description,
//       'size': size,
//       'id': id,
//       'price': price,
//       'images': images,
// 'color': color.value,
//       'quantity': quantity,
//     };
//   }

//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       map['title'] as String,
//       map['description'] as String,
//       map['size'] as String,
//       map['id'] as String,
//       map['price'] as double,
//       List<String>.from((map['images'] as List<String>),
// Color(map['color'] as Sting),
//       map['quantity'] as int,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// List<Product> products = [
//   Product(
//       id: "1",
//       title: "Office Code",
//       price: 234,
//       quantity: 6,
//       size: "12",
//       description: dummyText,
//       images: ["assets/images/bag_1.png"],
//       // // color: Color(0xFF3D82AE),
//       category: ""),
//   Product(
//       id: "2",
//       title: "Belt Bag",
//       price: 234,
//       size: "8",
//       quantity: 6,
//       description: dummyText,
//       images: ["assets/images/bag_2.png"],
//       // // color: Color(0xFFD3A984),
//       category: ""),
//   Product(
//       id: "3",
//       title: "Hang Top",
//       price: 234,
//       size: "10",
//       quantity: 6,
//       description: dummyText,
//       images: ["assets/images/bag_3.png"],
//       // // color: Color(0xFF989493),
//       category: ""),
//   Product(
//       id: "4",
//       title: "Old Fashion",
//       price: 234,
//       size: "11",
//       quantity: 6,
//       description: dummyText,
//       images: ["assets/images/bag_4.png"],
//       // // color: Color(0xFFE6B398),
//       category: ""),
//   Product(
//       id: "5",
//       title: "Office Code",
//       price: 234,
//       quantity: 6,
//       size: "12",
//       description: dummyText,
//       images: ["assets/images/bag_5.png"],
//       // // color: Color(0xFFFB7883),
//       category: ""),
//   Product(
//       id: "6",
//       title: "Office Code",
//       price: 234,
//       quantity: 6,
//       size: "12",
//       description: dummyText,
//       images: ["assets/images/bag_6.png"],
//       // // color: Color(0xFFAEAEAE),
//       category: ""),
// ];

// String dummyText =
//     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";

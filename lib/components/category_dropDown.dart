import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:online_shopping_store/global_content.dart';

class CategorySelectDropDown extends StatefulWidget {
  CategorySelectDropDown({
    super.key,
    this.selectedItem,
    required this.selectCat,
  });
  final Function(Category) selectCat;
  late Category? selectedItem;
  // final Function() showBottomModal;
  @override
  State<CategorySelectDropDown> createState() => _CategorySelectDropDownState();
}

class _CategorySelectDropDownState extends State<CategorySelectDropDown> {
  late Future<TreeNode> futureCategories;

  Future<TreeNode> fetchCategoryHierarchy(BuildContext context) async {
    final client = RetryClient(http.Client());

    var response = await client.post(
      Uri.http(uri, '/api/category/all-sub-catogeries'),
    );

    if (response.statusCode == 200) {
      return buildTreeNode(
          Category.fromMap(json.decode(response.body)['hirechy']), context);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  TreeNode buildTreeNode(Category node, BuildContext context) {
    return TreeNode(
      content: GestureDetector(
          onTap: () {
            setState(() {
              widget.selectedItem = node;
            });
            Navigator.pop(context); // Close the bottom sheet
            print(widget.selectedItem!.id);
            widget.selectCat(node);
          },
          child: Text(node.name)),
      children: node.children.isNotEmpty
          ? node.children
              .map<TreeNode>((child) => buildTreeNode(child, context))
              .toList()
          : [],
    );
  }

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategoryHierarchy(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FutureBuilder<TreeNode>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return TreeView(
              indent: 20,
              nodes: [snapshot.data!],
            );
          }
        },
      ),
    );
  }
}

class Category {
  final String id;
  final String name;
  final List<Category> children;

  Category({
    required this.id,
    required this.name,
    required this.children,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'],
      name: map['name'],
      children: map['children'] != null
          ? List<Category>.from(map['children'].map((x) => Category.fromMap(x)))
          : [],
    );
  }
}

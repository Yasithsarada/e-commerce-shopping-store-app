  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'package:http/retry.dart';
  import 'package:online_shopping_store/components/dialogbox.dart';
  import 'package:online_shopping_store/global_content.dart';
  import 'package:online_shopping_store/models/category.dart';

  Future<Category> fetchCategoryHierarchy() async {
    final client = RetryClient(http.Client());

    var response = await client.post(
      Uri.http(uri, '/api/category/all-sub-catogeries'),
    );

    if (response.statusCode == 200) {
      var x = json.decode(response.body)['hirechy'];
      print("x - $x");
      return Category.fromMap(json.decode(response.body)['hirechy']);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  class CategorySelector extends StatefulWidget {
    @override
    _CategorySelectorState createState() => _CategorySelectorState();
  }

  class _CategorySelectorState extends State<CategorySelector> {
    late Future<Category> futureCategoryHierarchy;
    Category? selectedCategory;

    @override
    void initState() {
      super.initState();
      futureCategoryHierarchy = fetchCategoryHierarchy();
    }

    @override
    Widget build(BuildContext context) {
      return FutureBuilder<Category>(
        future: futureCategoryHierarchy,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            dialogBox(context, 'Error occurred: ${snapshot.error}', "Try again!",
                "Retry");
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No categories found');
          } else {
            return ListView(
              children: [buildCategoryTile(snapshot.data!)],
            );
          }
        },
      );
    }

    Widget buildCategoryTile(Category category) {
      return ExpansionTile(
        collapsedBackgroundColor: Colors.blueGrey.withOpacity(0.1),
        backgroundColor: Colors.blueGrey.withOpacity(0.05),
        collapsedShape: RoundedRectangleBorder( 
          borderRadius: BorderRadius.circular(10),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        title: Text(category.name),
        children: category.children.map((child) {
          return buildCategoryTile(child);
        }).toList(),
        onExpansionChanged: (isExpanded) {
          if (isExpanded) {
            setState(() {
              selectedCategory = category;
            });
          }
        },
      );
    }
  }

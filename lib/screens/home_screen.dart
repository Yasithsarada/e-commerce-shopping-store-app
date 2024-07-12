import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:online_shopping_store/components/produc_card.dart';
import 'package:online_shopping_store/constants.dart';
import 'package:online_shopping_store/global_content.dart';
import 'package:online_shopping_store/models/product.dart';
import 'package:online_shopping_store/provider/user_provider.dart';
import 'package:online_shopping_store/screens/add_product.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeCategory = 0;
  List<Product> productList = [];

  Future fetchProducts() async {
    final client = RetryClient(http.Client());

    var response = await client.get(
      Uri.http(uri, '/api/products/all-products'),
    );
    print("response:   ${(response.statusCode)}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic>? productDecoded = decodedResponse['products'];
      print("response:   ${productDecoded}");

      if (productDecoded != null) {
        print("Not nulll");
        setState(() {
          productList = productDecoded
              .map((product) => Product.fromMap(product)) 
              .toList();
        });
      } else {
        // Handle the case when 'products' is null
        throw Exception('No products found');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final String username = Provider.of<UserProvider>(context).user.username;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hi $username"),
        leading: const Icon(
          Icons.arrow_back,
          color: kTextColor,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: kTextColor,
              )),
          const Icon(Icons.shopping_cart),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddProduct()));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              "Women",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          // Container(
          //   height: 50,
          //   width: double.infinity,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: ((context, index) => GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               _activeCategory = index;
          //             });
          //           },
          //           child: CategoryCard(
          //             index: index,
          //             categoryName: categories[index],
          //             activeCat: _activeCategory,
          //           ),
          //         )),
          //     itemCount: categories.length,
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                itemCount: productList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: kDefaultPaddin,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisCount: 2,
                    childAspectRatio: 0.75),
                itemBuilder: (context, index) => ProductCard(
                  product: productList[index],
                ),
                scrollDirection: Axis.vertical,
              ),
            ),
          )
        ],
      ),
    );
  }
}

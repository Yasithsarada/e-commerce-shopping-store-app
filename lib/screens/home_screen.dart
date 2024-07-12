import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:online_shopping_store/components/produc_card.dart';
import 'package:online_shopping_store/constants.dart';
import 'package:online_shopping_store/global_content.dart';
import 'package:online_shopping_store/models/category.dart';
import 'package:online_shopping_store/models/product.dart';
import 'package:online_shopping_store/provider/user_provider.dart';
import 'package:online_shopping_store/screens/add_product.dart';
import 'package:provider/provider.dart';
import 'package:online_shopping_store/components/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeCategory = 0;
  List<Product> productList = [];
  // late Future<List<Category>> _categoryList;
  late Future<List<Category>> _categoryList;

  Future fetchProducts() async {
    final client = RetryClient(http.Client());

    var response = await client.get(
      Uri.http(uri, '/api/products/all-products'),
    );
    // print("response:   ${(response.statusCode)}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final List<dynamic>? productDecoded = decodedResponse['products'];
      // print("response:   ${productDecoded}");

      if (productDecoded != null) {
        // print("Not nulll");
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

  Future<List<Category>> fetchMainCategories() async {
    final client = RetryClient(http.Client());

    var response = await client.get(
      Uri.http(uri, '/api/category/main-catogeries'),
    );

    print("response.status : ${response.statusCode}");
    if (response.statusCode == 200) {
      print("response.body : ${jsonDecode(response.body)}");
      List<dynamic> categoriesJson = jsonDecode(response.body)['categories'];
      return categoriesJson.map((e) => Category.fromMap(e)).toList();
      // return Category.fromMap(json.decode(response.body)['categories']);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchMainCategories();
    _categoryList = fetchMainCategories();
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
            padding: const EdgeInsets.all(16.0),
            child: SearchAnchor(
                viewBackgroundColor: Colors.transparent,
                viewSurfaceTintColor: Colors.transparent,
                dividerColor: Colors.transparent,
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      // controller.openView();
                    },
                    onChanged: (_) {
                      // controller.openView();
                    },
                    leading: const Icon(Icons.search),
                    trailing: <Widget>[
                      Tooltip(
                        message: 'Change brightness mode',
                        child: IconButton(
                          // isSelected: isDark,
                          onPressed: () {
                            setState(() {
                              // isDark = !isDark;
                            });
                          },
                          icon: const Icon(Icons.wb_sunny_outlined),
                          selectedIcon: const Icon(Icons.brightness_2_outlined),
                        ),
                      )
                    ],
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                }),
          ),
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
          Container(
              height: 50,
              width: double.infinity,
              child: FutureBuilder(
                future: _categoryList,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Loading....');
                    default:
                      if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
                        return Text('Error: ${snapshot.error}');
                      } else {
                        print('Result: ${snapshot.data}');
                        // return Text('Result: ${snapshot.data}');
                        List<Category> categories = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _activeCategory = index;
                                });
                              },
                              child: CategeryCard(
                                  categoryName: categories[index].name,
                                  activeCat: _activeCategory,
                                  index: index)
                              // CategoryCard(
                              //   index: index,
                              //   categoryName: categories[index],
                              //   activeCat: _activeCategory,
                              // ),
                              )),
                          itemCount: categories.length,
                        );
                      }
                  }
                },
              )),
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:online_shopping_store/components/loader.dart';
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
  late Future<List<Product>> _productList;

  Future<List<Product>> fetchProducts() async {
    final client = RetryClient(http.Client());

    var response = await client.get(
      Uri.http(uri, '/api/products/all-products'),
    );
    // print("response:   ${(response.statusCode)}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      print(decodedResponse);
      final List<dynamic>? productDecoded = decodedResponse['products'];
      // print("response:   ${productDecoded}");

      if (productDecoded != null) {
        // print("Not nulll");
        // setState(() {
        // productList = productDecoded
        //     .map((product) => Product.fromMap(product))
        //     .toList();
        // });
        return productDecoded
            .map((product) => Product.fromMap(product))
            .toList();
      } else {
        return [];
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

  Future<List<Product>> searchProducts(searchQuery) async {
    final client = RetryClient(http.Client());
    final queryParameters = {"searchQuery": '$searchQuery'};
    var response = await client.get(
      Uri.http(uri, '/api/products/search-product', queryParameters),
    );

    print("response.status : ${response.statusCode}");
    if (response.statusCode == 200) {
      print("response.body : ${jsonDecode(response.body)}");
      List<dynamic> productsJson = jsonDecode(response.body)['products'];
      // <List<Product>> searchedProducts =
      // ListView.builder(
      //   itemCount: productsJson.length,
      //   itemBuilder: (context, index) => ListTile(
      //     title: productsJson[index].title,
      //   ),
      // );
      productsJson.map((e) => print(e));
      return productsJson.map((e) => Product.fromMap(e)).toList();
      // List<Product> searchedProducts =
      //     productsJson.map((e) => Product.fromMap(e)).toList();
      // return Category.fromMap(json.decode(response.body)['categories']);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchProducts();
    // fetchMainCategories();
    _categoryList = fetchMainCategories();
    _productList = fetchProducts();
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
                  .push(MaterialPageRoute(builder: (_) => const AddProduct()));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: SearchBar(
          //     hintText: "Search",
          //     // hintStyle: MaterialStateProperty<TextStyle>(col),
          //     side: const MaterialStatePropertyAll(
          //         const BorderSide(color: Colors.black45)),
          //     shadowColor: const MaterialStatePropertyAll(Colors.transparent),
          //     overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          //     backgroundColor:
          //         MaterialStatePropertyAll(Color.fromARGB(255, 255, 255, 255)),
          //     // controller: controller,
          //     padding: const MaterialStatePropertyAll<EdgeInsets>(
          //         EdgeInsets.symmetric(horizontal: 16.0)),
          //     shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
          //         RoundedRectangleBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          //     onTap: () {
          //       // controller.openView();
          //     },
          //     onChanged: (e) {
          //       print(e);
          //       // searchProducts(e);
          //       setState(() {
          //         _productList = searchProducts(e);
          //       });
          //       // controller.openView();
          //     },
          //     leading: const Icon(Icons.search),
          //     // trailing: <Widget>[
          //     //   Tooltip(
          //     //     message: 'Change brightness mode',
          //     //     child: IconButton(
          //     //       // isSelected: isDark,
          //     //       onPressed: () {
          //     //         setState(() {
          //     //           // isDark = !isDark;
          //     //         });
          //     //       },
          //     //       icon: const Icon(Icons.wb_sunny_outlined),
          //     //       selectedIcon: const Icon(Icons.brightness_2_outlined),
          //     //     ),
          //     //   )
          //     // ],
          //   ),
          // ),
          Container(
            height: 90,
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (e) {
                print(e);
                // searchProducts(e);
                setState(() {
                  _productList = searchProducts(e);
                });
                // controller.openView();
              },
              // controller: _controller,
              // maxLength: 50,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(0.1),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                          // color: Colors.black12,
                          )),
                  // hintText: hintText,
                  // prefixText: prefix ?? "",
                  // label: Text(
                  //   hintText,
                  //   style: const TextStyle(fontSize: 20),
                  // ),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search products"),

              keyboardType: TextInputType.text,
            ),
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
                      return const Loader();
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
          FutureBuilder(
            future: _productList,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Loader();
                  break;
                default:
                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  } else {
                    productList = snapshot.data!;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GridView.builder(
                          itemCount: productList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                    );
                  }
              }
            },
          )
        ],
      ),
    );
  }
}
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/retry.dart';
// import 'package:online_shopping_store/components/loader.dart';
// import 'package:online_shopping_store/components/produc_card.dart';
// import 'package:online_shopping_store/constants.dart';
// import 'package:online_shopping_store/global_content.dart';
// import 'package:online_shopping_store/models/category.dart';
// import 'package:online_shopping_store/models/product.dart';
// import 'package:online_shopping_store/provider/user_provider.dart';
// import 'package:online_shopping_store/screens/add_product.dart';
// import 'package:provider/provider.dart';
// import 'package:online_shopping_store/components/category_card.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _activeCategory = 0;
//   List<Product> productList = [];
//   late Future<List<dynamic>> _futures;

//   Future<List<Product>> fetchProducts() async {
//     final client = RetryClient(http.Client());

//     var response = await client.get(
//       Uri.http(uri, '/api/products/all-products'),
//     );
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
//       final List<dynamic>? productDecoded = decodedResponse['products'];
//       if (productDecoded != null) {
//         return productDecoded
//             .map((product) => Product.fromMap(product))
//             .toList();
//       } else {
//         return [];
//       }
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   Future<List<Category>> fetchMainCategories() async {
//     final client = RetryClient(http.Client());

//     var response = await client.get(
//       Uri.http(uri, '/api/category/main-catogeries'),
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> categoriesJson = jsonDecode(response.body)['categories'];
//       return categoriesJson.map((e) => Category.fromMap(e)).toList();
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }

//   Future<List<Product>> searchProducts(searchQuery) async {
//     final client = RetryClient(http.Client());
//     final queryParameters = {"searchQuery": '$searchQuery'};
//     var response = await client.get(
//       Uri.http(uri, '/api/products/search-product', queryParameters),
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> productsJson = jsonDecode(response.body)['products'];
//       return productsJson.map((e) => Product.fromMap(e)).toList();
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _futures = Future.wait([fetchMainCategories(), fetchProducts()]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String username = Provider.of<UserProvider>(context).user.username;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Hi $username"),
//         leading: const Icon(
//           Icons.arrow_back,
//           color: kTextColor,
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.search,
//                 color: kTextColor,
//               )),
//           const Icon(Icons.shopping_cart),
//           IconButton(
//             onPressed: () {
//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (_) => AddProduct()));
//             },
//             icon: const Icon(Icons.add),
//           )
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SearchBar(
//               hintText: "Search",
//               side: MaterialStatePropertyAll(BorderSide(color: Colors.black45)),
//               shadowColor: MaterialStatePropertyAll(Colors.transparent),
//               overlayColor: MaterialStatePropertyAll(Colors.transparent),
//               backgroundColor: MaterialStatePropertyAll(Colors.white),
//               padding: const MaterialStatePropertyAll<EdgeInsets>(
//                   EdgeInsets.symmetric(horizontal: 16.0)),
//               shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)))),
//               onTap: () {},
//               onChanged: (e) {
//                 setState(() {
//                   _futures = Future.wait([
//                     _futures.then((data) => data[0]), // Keep categories
//                     searchProducts(e)
//                   ]);
//                 });
//               },
//               leading: const Icon(Icons.search),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
//             child: Text(
//               "Women",
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineSmall!
//                   .copyWith(fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Expanded(
//             child: FutureBuilder<List<dynamic>>(
//               future: _futures,
//               builder: (context, snapshot) {
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.waiting:
//                     return Loader();
//                   default:
//                     if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       List<Category> categories = snapshot.data![0];
//                       productList = snapshot.data![1];
//                       return Column(
//                         children: [
//                           Container(
//                             height: 50,
//                             width: double.infinity,
//                             child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: ((context, index) => GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       _activeCategory = index;
//                                     });
//                                   },
//                                   child: CategeryCard(
//                                       categoryName: categories[index].name,
//                                       activeCat: _activeCategory,
//                                       index: index))),
//                               itemCount: categories.length,
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: kDefaultPaddin),
//                               child: GridView.builder(
//                                 itemCount: productList.length,
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisSpacing: kDefaultPaddin,
//                                         mainAxisSpacing: kDefaultPaddin,
//                                         crossAxisCount: 2,
//                                         childAspectRatio: 0.75),
//                                 itemBuilder: (context, index) => ProductCard(
//                                   product: productList[index],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

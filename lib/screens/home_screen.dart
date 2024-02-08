import 'package:flutter/material.dart';
import 'package:online_shopping_store/components/category_card.dart';
import 'package:online_shopping_store/components/produc_card.dart';
import 'package:online_shopping_store/constants.dart';
import 'package:online_shopping_store/data/Product.dart';
import 'package:online_shopping_store/data/model_data.dart';
import 'package:online_shopping_store/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeCategory = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          const Icon(Icons.shopping_cart)
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
          Container(
            height: 50,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _activeCategory = index;
                        print(_activeCategory);
                      });
                      // print(_activeCategory);
                    },
                    child: CategeryCard(
                      index: index,
                      categoryName: categories[index],
                      activeCat: _activeCategory,
                    ),
                  )),
              itemCount: categories.length,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                // padding: EdgeInsets.all(4.0),
                itemCount: products.length,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: kDefaultPaddin,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisCount: 2,
                    childAspectRatio: 0.75),

                itemBuilder: (context, index) => ProductCard(
                  product: products[index],
                  // onPress: () { },
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

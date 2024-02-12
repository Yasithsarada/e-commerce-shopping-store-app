import 'package:flutter/material.dart';
import 'package:online_shopping_store/components/color_selectionDot.dart';
import 'package:online_shopping_store/components/quantity_crement.dart';
import 'package:online_shopping_store/constants.dart';
import 'package:online_shopping_store/data/Product.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.product});
  final Product product;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int noOfItems = 1;
  var _isFavorite = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    print(size);
    return Scaffold(
      backgroundColor: widget.product.color,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white70,
              )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white70,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white70,
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.32),
                  height: screenHeight * 1.1,
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    // child:Text("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "classic handbag",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        widget.product.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Row(children: [
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(text: "Price\n"),
                          TextSpan(
                            text: '\$ ${widget.product.price.toString()}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          )
                        ])),
                        const SizedBox(
                          width: kDefaultPaddin,
                        ),
                        Expanded(
                          child: Image.asset(
                            widget.product.image,
                            fit: BoxFit.fill,
                          ),
                        )
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Color"),
                                Row(
                                  children: [
                                    ColorSelectionDot(
                                      color: Color(0xFF3D82AE),
                                      isSelected: true,
                                    ),
                                    ColorSelectionDot(
                                      color: Color(0xFFFB7883),
                                      isSelected: false,
                                    ),
                                    ColorSelectionDot(
                                      color: Color(0xFFE6B398),
                                      isSelected: false,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //     right: size.width * 0.25,
                          //     top: 10,
                          //   ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  style: const TextStyle(color: kTextColor),
                                  children: [
                                    const TextSpan(text: "Size\n"),
                                    TextSpan(
                                      text: "${widget.product.size}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 97.0,
                        child: RichText(
                          text: TextSpan(
                              style: const TextStyle(color: kTextColor),
                              children: [
                                TextSpan(
                                    text: "Description\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                const WidgetSpan(
                                  child: SizedBox(
                                      height:
                                          30), // Add space between TextSpans
                                ),
                                const TextSpan(
                                  text:
                                      " in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                )
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              QuantityCrement(
                                icon: Icons.remove,
                                onPress: () {
                                  setState(() {
                                    noOfItems--;
                                  });
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  noOfItems.toString().padLeft(2, "0"),
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              QuantityCrement(
                                  icon: Icons.add,
                                  onPress: () {
                                    setState(() {
                                      noOfItems++;
                                    });
                                  }),
                            ],
                          ),
                          IconButton(
                            color: _isFavorite
                                ? Colors.red
                                : kDefaultIconDarkColor,
                            style: const ButtonStyle(),
                            onPressed: () {},
                            icon: Icon(
                                _isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 30),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: kDefaultPaddin * 3 / 4,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton.outlined(
                              iconSize: 30.0,
                              color: const Color(0xFF3D82AE),
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(13))),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.all(0.0)),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.shopping_cart_outlined)),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.product.color,
                                    textStyle: const TextStyle(color: Colors.white)),
                                onPressed: () {},
                                child: const Text(
                                  "Buy Now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  height: 500,
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
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
                        height: 20,
                      ),
                      RichText(
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
                                    height: 40), // Add space between TextSpans
                              ),
                              const TextSpan(
                                  text:
                                      "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                            ]),
                      ),
                      SizedBox(
                        height: kDefaultPaddin,
                      ),
                      Row(
                        children: [
                          // SizedBox(
                          //   width: 40,
                          //   height: 32,
                          //   child: OutlinedButton(
                          //     onPressed: () {},
                          //     style: ButtonStyle(
                          //       shape: MaterialStatePropertyAll(
                          //         RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(13)),
                          //       ),
                          //     ),
                          //     child: const Icon(Icons.remove),
                          //   ),
                          // ),
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
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          QuantityCrement(
                              icon: Icons.add,
                              onPress: () {
                                setState(() {
                                  noOfItems++;
                                });
                              })
                        ],
                      )
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

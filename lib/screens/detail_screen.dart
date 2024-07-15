import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:online_shopping_store/components/color_selectionDot.dart';
import 'package:online_shopping_store/components/quantity_crement.dart';
import 'package:online_shopping_store/constants.dart';
import 'package:online_shopping_store/data/productData.dart';
import 'package:online_shopping_store/models/product.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';

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

    // List<Image> imageList = widget.product.images
    //     .map(
    //       (e) => Image.network(
    //         height: 200,
    //         widget.product.images[0],
    //         fit: BoxFit.fitHeight,
    //       ),
    //     )
    //     .toList();

    return Scaffold(
      // backgroundColor: widget.product.color,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.secondary,
              )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                // Image.network(
                //   height: 200,
                //   widget.product.images[0],
                //   fit: BoxFit.fitHeight,
                // ),

                CarouselSlider(
                  items: widget.product.images.isEmpty
                      ? [Image.asset('assets/images/noD.png')]
                      : widget.product.images
                          .map(
                            (e) => Image.network(
                              height: 200,
                              e,
                              fit: BoxFit.cover,
                            ),
                          )
                          .toList(),
                  options: CarouselOptions(
                    viewportFraction: 0.8,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                  ),
                  disableGesture: false,
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.08),
                  height: screenHeight * 1.1,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    // child:Text("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 10,)
                        // Text(
                        //   "classic handbag",
                        //   textAlign: TextAlign.start,
                        //   style: TextStyle(
                        //       color:
                        //           Theme.of(context).colorScheme.secondary),
                        // ),

                        PannableRatingBar(
                          rate: 5,
                          onChanged: (value) {},
                          // onHover: updateRating,
                          spacing: 20,
                          items: List.generate(
                            5,
                            (index) => const RatingWidget(
                              selectedColor: Colors.amber,
                              unSelectedColor: Colors.grey,
                              child: Icon(
                                Icons.star,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          widget.product.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 8),
                          child: Row(children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Price\n",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              TextSpan(
                                text: '\$ ${widget.product.price.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.bold),
                              )
                            ])),
                            const SizedBox(
                              width: kDefaultPaddin,
                            ),
                          ]),
                        ),

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
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const WidgetSpan(
                                    child: SizedBox(
                                        height:
                                            30), // Add space between TextSpans
                                  ),
                                  TextSpan(
                                    text: widget.product.description,
                                  )
                                ]),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Text(
                                    noOfItems.toString().padLeft(2, "0"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
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
                                // color: const Color(0xFF3D82AE),
                                color: Theme.of(context).colorScheme.secondary,
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13))),
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.all(0.0)),
                                ),
                                onPressed: () {},
                                icon: const Icon(
                                    Icons.add_shopping_cart_outlined)),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      // backgroundColor: widget.product.color,
                                      textStyle:
                                          const TextStyle(color: Colors.white)),
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:online_shopping_store/constants.dart';
import 'package:online_shopping_store/data/productData.dart';
import 'package:online_shopping_store/models/product.dart';
import 'package:online_shopping_store/screens/detail_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    // required this.onPress,
  });
  final Product product;
  // final Function() onPress;

  @override
  Widget build(BuildContext context) {
    // print("Product  ||||||||||||||||||||||||||||| : $product");
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(
                  product: product,
                )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(kDefaultPaddin),
              // color: productColor,
              // width: 160,
              // height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: product.images.isEmpty
                      ? AssetImage('assets/images/noD.png') as ImageProvider
                      : NetworkImage(product.images[0]),
                  // fit: BoxFit.fitHeight, // Adjust this as needed
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            product.title,
            // maxLines: 2,
            overflow: TextOverflow.ellipsis,
            // style: const TextStyle(color: kTextColor),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '\$ ${product.price.toString()}',
            style:
                const TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:online_shopping_store/constants.dart';
import 'package:online_shopping_store/data/Product.dart';
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
                  color: product.color,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(product.image),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            product.title,
            style: const TextStyle(color: kTextColor),
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

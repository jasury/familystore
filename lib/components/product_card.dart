import 'package:flutter/material.dart';
import 'package:store/constants/colors.dart';
import 'package:store/data/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback press;
  const ProductCard({
    required Key key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
            gradient: appMainGradient,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  //side: new BorderSide(color: detailImageBorder, width: 2.0)
                ),
                child: Hero(
                  tag: "${product.id}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(product.image, fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPaddin / 4),
                    child: Text(
                      product.category,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(
                    "${product.price} won",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

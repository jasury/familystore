import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:store/components/app/pay_and_buy_button.dart';
import 'package:store/constants/colors.dart';
import 'package:store/data/product.dart';
import 'package:store/database/cart_item.dart';
import 'package:store/pages/payment/payment_page.dart';

class DetailsPage extends StatefulWidget {
  final Product product;
  const DetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState(product: product);
}

class _DetailsPageState extends State<DetailsPage> {
  final Product product;
  bool isAddedtoCart = false;

  _DetailsPageState({required this.product});

  void toggle() {
    setState(() {
      isAddedtoCart = !isAddedtoCart;
    });
  }

  bool isAdded(int id) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width - 16;
    String formattedPrice = "";
    String price = product.price.toString();
    List<CartItem> cartItem = CartItemBox.get()
        .values
        .toList()
        .where((item) => item.id == product.id)
        .toList();

    setState(() {
      isAddedtoCart = cartItem.isNotEmpty;
    });

    for (int i = price.length - 1, k = 1; i >= 0; i--, k++) {
      if (k % 3 == 0) {
        formattedPrice = " " + price[i] + formattedPrice;
      } else {
        formattedPrice = price[i] + formattedPrice;
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: detailImageBorder),
                    boxShadow: const [
                      BoxShadow(
                        color: detailImageShadow,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(image: AssetImage(product.image)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 8, right: 8, top: 8, bottom: imageSize - 64),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              color: detailImageShadow,
                              border: Border.all(
                                  color: detailImageShadow, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: IconButton(
                              padding: EdgeInsets.only(left: 8),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              color: detailImageShadow,
                              border: Border.all(
                                  color: detailImageShadow, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                !isAddedtoCart
                                    ? Icons.add_shopping_cart_outlined
                                    : Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                isAddedtoCart
                                    ? CartItemBox.delete(cartItem[0])
                                    : CartItemBox.create(
                                        product.id,
                                        product.type,
                                        product.category,
                                        product.price,
                                        product.image);
                                toggle();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  RatingBarIndicator(
                    rating: product.rating,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: detailImageShadow,
                    ),
                    itemCount: 5,
                    itemSize: 36.0,
                    direction: Axis.horizontal,
                    unratedColor: Colors.orange[100],
                  ),
                  Text(
                    " ${product.rating} | ${product.sold} sold.",
                    style: const TextStyle(fontSize: 16, color: kTextColor),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Price: $formattedPrice won",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24,
                    color: kTextColor,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: kTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Family Store",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: kTextLightColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Center(
            child: payAndBuyButton("Buy", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentPage(price: product.price),
              ));
        })),
      ),
    );
  }
}

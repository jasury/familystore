import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:store/components/app/pay_and_buy_button.dart';
import 'package:store/constants/colors.dart';
import 'package:store/database/cart_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store/pages/payment/payment_page.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 100),
        Center(
            child:
                Lottie.asset("assets/animations/empty_box.json", repeat: true)),
      ],
    );
  }
}

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder<Box<CartItem>>(
      valueListenable: CartItemBox.get().listenable(),
      builder: (context, box, _) {
        final cartItems = box.values.toList().cast<CartItem>();
        int sum = 0;
        for (int i = 0; i < cartItems.length; i++) {
          sum += cartItems[i].price;
        }

        return SingleChildScrollView(
          child: (sum != 0)
              ? Column(
                  children: <Widget>[
                    ...(cartItems.map((item) => singleItem(item, size))),
                    payAndBuyButton(
                      "Total: $sum pay won",
                      () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                price: sum,
                              ),
                            ))
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : EmptyCart(),
        );
      },
    );
  }

  Container singleItem(CartItem item, Size size) {
    String type = "Men";
    if (item.type == "women") {
      type = "Women";
    }
    if (item.type == "children") {
      type = "Kids";
    }

    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: size.height * 0.16,
            height: size.height * 0.16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(item.image, fit: BoxFit.fill),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6, bottom: 6, right: 8, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${item.price} won",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: kTextColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  type,
                  style: const TextStyle(fontSize: 14, color: kTextLightColor),
                ),
                Text(
                  item.category,
                  style: const TextStyle(fontSize: 14, color: kTextLightColor),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: IconButton(
                      onPressed: () {
                        CartItemBox.delete(item);
                      },
                      icon: Lottie.asset("assets/animations/bin.json",
                          repeat: true))),
            ],
          )
        ],
      ),
    );
  }
}

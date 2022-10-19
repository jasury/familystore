import 'package:flutter/material.dart';
import 'package:store/constants/colors.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    flexibleSpace:
        Container(decoration: const BoxDecoration(gradient: appMainGradient)),
    elevation: 0,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: iconColor,
      ),
      onPressed: () => Navigator.pop(context),
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.search,
          color: iconColor,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(
          Icons.shopping_cart,
          color: iconColor,
        ),
        onPressed: () {},
      ),
      const SizedBox(width: kDefaultPaddin / 2)
    ],
  );
}

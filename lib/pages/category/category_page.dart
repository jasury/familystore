import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store/components/app/app_bar.dart';
import 'package:store/components/product_card.dart';
import 'package:store/constants/colors.dart';
import 'package:store/data/filter.dart';
import 'package:store/data/product.dart';
import 'package:store/pages/category/category_panel.dart';
import 'package:store/pages/details/details.dart';

class CategoryPage extends StatefulWidget {
  final String type;
  final List<String> categories;

  CategoryPage({required this.type, required this.categories});

  @override
  CategoryPageState createState() =>
      CategoryPageState(type: type, categories: categories);
}

class CategoryPageState extends State<CategoryPage> {
  int selectedIndex = 0;
  String type;
  List<String> categories;
  String label = "Men";

  CategoryPageState({required this.type, required this.categories});

  void changeState(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: appMainGradient),
      ),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }

  Widget bodyBuiler(int currentIndex, List<Product> products) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: kDefaultPaddin,
              crossAxisSpacing: kDefaultPaddin,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) => ProductCard(
                  key: Key(products[index].id.toString()),
                  product: products[index],
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          key: Key(products[index].id.toString()),
                          product: products[index],
                        ),
                      )),
                )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (type == "men") {
      label = "Men";
    } else if (type == "women") {
      label = "Women";
    } else {
      label = "Kids";
    }

    return Scaffold(
        appBar: buildAppBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: kDefaultPaddin,
                  left: kDefaultPaddin,
                  right: kDefaultPaddin),
              child: Text(
                label,
                style: GoogleFonts.lobsterTwo(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Categories(
              changeBodyState: changeState,
              categories: categories,
            ),
            bodyBuiler(
                selectedIndex, filterProducts(type, categories[selectedIndex]))
          ],
        ));
  }
}

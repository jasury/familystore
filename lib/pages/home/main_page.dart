import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store/constants/colors.dart';
import 'package:store/constants/styles.dart';
import 'package:store/pages/home/checkout_page.dart';
import 'package:store/pages/home/home_page.dart';
import 'package:store/pages/home/search_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedPage = 1;
  final _pageOptions = [SearchPage(), HomePage(), CheckoutPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: _pageOptions[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        gradient: appMainGradient,
        style: TabStyle.reactCircle,
        color: Colors.white,
        backgroundColor: Color(0xffff723a),
        items: const [
          TabItem(icon: Icons.search, title: "Search"),
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.shopping_cart, title: "Cart"),
        ],
        initialActiveIndex: selectedPage,
        onTap: (int i) {
          setState(() {
            selectedPage = i;
          });
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: appMainGradient),
      ),
      elevation: 0,
      title: Center(
        child: Text(
          "Family Store",
          style: appBarTitleStyle,
        ),
      ),
    );
  }
}

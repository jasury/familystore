import 'package:flutter/material.dart';
import 'package:store/constants/colors.dart';

class Categories extends StatefulWidget {
  final void Function(int) changeBodyState;
  final List<String> categories;

  Categories({required this.changeBodyState, required this.categories});

  @override
  _CategoriesState createState() => _CategoriesState(
      changeBodyState: changeBodyState, categories: categories);
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0;
  final void Function(int) changeBodyState;
  final List<String> categories;

  _CategoriesState({required this.changeBodyState, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          changeBodyState(selectedIndex);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index
                    ? detailImageBorder
                    : kTextLightColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: kDefaultPaddin / 4),
              height: 2,
              width: 30,
              color: selectedIndex == index
                  ? detailImageBorder
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

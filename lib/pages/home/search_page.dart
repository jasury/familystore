import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:store/components/product_card.dart';
import 'package:store/constants/colors.dart';
import 'package:store/data/product.dart';
import 'package:store/data/search.dart';
import 'package:store/pages/details/details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> searchResult = [];
  String searchString = "";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Key inputKey = Key("input");
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: inputKey,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: detailImageBorder, width: 1)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: detailImageBorder, width: 1)),
                hintText: "Search",
                hintStyle: const TextStyle(color: detailImageBorder),
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: detailImageBorder,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: detailImageBorder,
                  ),
                  onPressed: () {
                    controller.text = "";

                    setState(() {
                      searchString = "";
                      searchResult = [];
                    });
                  },
                ),
              ),
              controller: controller,
              onChanged: (value) {
                setState(() {
                  searchString = value;
                  searchResult = searchProduct(searchString);
                });
              },
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: searchString.isNotEmpty
                ? (searchResult.isNotEmpty
                    ? GridView.builder(
                        itemCount: searchResult.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: kDefaultPaddin,
                          crossAxisSpacing: kDefaultPaddin,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) => ProductCard(
                              key: new Key(searchResult[index].id.toString()),
                              product: searchResult[index],
                              press: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                      key: new Key(
                                          searchResult[index].id.toString()),
                                      product: searchResult[index],
                                    ),
                                  )),
                            ))
                    : Lottie.asset("assets/animations/fail_search.json",
                        repeat: true))
                : Lottie.asset("assets/animations/search.json", repeat: true),
          )),
        ],
      ),
    );
  }
}

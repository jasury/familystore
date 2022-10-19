import 'package:store/data/all_products.dart';
import 'package:store/data/product.dart';

List<Product> searchProduct(String search) {
  return allProducts
      .where((element) => element.description.contains(search))
      .toList();
}

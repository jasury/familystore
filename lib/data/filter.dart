import 'package:store/data/all_products.dart';
import 'package:store/data/product.dart';

List<Product> filterProducts(String type, String category) {
  return allProducts
      .where((product) => product.type == type && product.category == category)
      .toList();
}

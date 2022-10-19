import 'package:hive/hive.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  late String type;

  @HiveField(1)
  late String category;

  @HiveField(2)
  late String image;

  @HiveField(3)
  late int price;

  @HiveField(4)
  late int id;
}

class CartItemBox {
  static Box<CartItem> get() {
    return Hive.box<CartItem>("cartitems");
  }

  static Future create(
      int id, String type, String category, int price, String image) async {
    final cartItem = CartItem()
      ..type = type
      ..price = price
      ..category = category
      ..image = image
      ..id = id;

    final box = get();
    box.add(cartItem);
  }

  static void update(CartItem item) {
    item.save();
  }

  static void delete(CartItem item) {
    item.delete();
  }
}

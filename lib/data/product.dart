class Product {
  final int id;
  final int price;
  final double rating;
  final String image;
  final String description;
  final String type;
  final String category;
  final int sold;
  final int left;

  // constuctor
  Product(
      {required this.id,
      required this.price,
      required this.rating,
      required this.image,
      required this.description,
      required this.type,
      required this.category,
      required this.left,
      required this.sold});
}

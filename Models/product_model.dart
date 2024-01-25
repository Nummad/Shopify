class Product {
  final String name;
  final String description;
  final String category;
  final int quantity;
  final int price;
  final List<String> images;

  Product(
      {required this.name,
      required this.description,
      required this.category,
      required this.quantity,
      required this.price,
      required this.images});
}

class ProductDataModel {
  final int id;
  final String name, category, imageUrl;
  final double price, quantity;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.category,
      required this.imageUrl,
      required this.price,
      required this.quantity});
}

class ProductDataModel {
  final int id;
  final String name, description, imageUrl;
  final double price;
  final int quantity;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.price,
      required this.quantity});
}

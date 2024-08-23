class CartItem {
  final String id;
  final String title;
  final String company;
  final double price;
  final int size;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.title,
    required this.company,
    required this.price,
    required this.size,
    required this.quantity,
    required this.imageUrl,
});
}
import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_items.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items {
    return [..._items];
  }
  

  void addItem(String productId, String title, String company, double price, int size, String imageUrl) {
    // Check if item already exists in the cart
    int existingIndex = _items.indexWhere((item) => item.id == productId && item.size == size);

    if (existingIndex >= 0) {
      // If item exists, update the quantity
      _items[existingIndex] = CartItem(
        id: _items[existingIndex].id,
        title: _items[existingIndex].title,
        company: _items[existingIndex].company,
        price: _items[existingIndex].price,
        size: _items[existingIndex].size,
        quantity: _items[existingIndex].quantity + 1,
        imageUrl: _items[existingIndex].imageUrl,
      );
    } else {
      // If item doesn't exist, add it to the cart
      _items.add(CartItem(
        id: productId,
        title: title,
        company: company,
        price: price,
        size: size,
        quantity: 1,
        imageUrl: imageUrl,
      ));
    }
    notifyListeners();
  }

  
  void removeItem(String productId, int size) {
    _items.removeWhere((item) => item.id == productId && item.size == size);
    notifyListeners();
  }

  void increaseQuantity(String productId, int size) {
    int index = _items.indexWhere((item) => item.id == productId && item.size == size);
    if (index >= 0) {
      _items[index].quantity += 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(String productId, int size) {
    int index = _items.indexWhere((item) => item.id == productId && item.size == size);
    if (index >= 0 && _items[index].quantity > 1) {
      _items[index].quantity -= 1;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void clear() {
    _items = [];
    notifyListeners();
}
}

import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cart = [];

  List<CartItem> get cart => _cart;

  void addToCart(Product product) {
    final index = _cart.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _cart[index].quantity++;
    } else {
      _cart.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    final index = _cart.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      if (quantity <= 0) {
        _cart.removeAt(index);
      } else {
        _cart[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  double get totalAmount {
    return _cart.fold(0, (total, item) => total + (item.product.price * item.quantity));
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}

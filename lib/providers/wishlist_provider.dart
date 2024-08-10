import 'package:flutter/foundation.dart';
import '../models/product.dart';

class WishlistProvider with ChangeNotifier {
  List<Product> _wishlist = [];

  List<Product> get wishlist => _wishlist;

  void addToWishlist(Product product) {
    if (!_wishlist.contains(product)) {
      _wishlist.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(Product product) {
    _wishlist.remove(product);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wishlist_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  ProductDetailPage({required this.productId});

  @override
  Widget build(BuildContext context) {
    // Fetch the product using the productId
    final product = Provider.of<ProductProvider>(context).getProductById(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              height: 250,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Rs.${product.price}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    cartProvider.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to cart')),
                    );
                  },
                  child: Text('Add to Cart'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (wishlistProvider.wishlist.contains(product)) {
                      wishlistProvider.removeFromWishlist(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Removed from wishlist')),
                      );
                    } else {
                      wishlistProvider.addToWishlist(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added to wishlist')),
                      );
                    }
                  },
                  child: Text(
                    wishlistProvider.wishlist.contains(product)
                        ? 'Remove from Wishlist'
                        : 'Add to Wishlist',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

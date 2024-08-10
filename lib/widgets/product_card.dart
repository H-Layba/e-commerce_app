import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../views/product/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);


    Color lighterPurple = HSLColor.fromColor(Colors.deepPurple)
        .withLightness(0.9)
        .toColor();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(productId: product.id),
          ),
        );
      },
      child: Card(
        color: lighterPurple,  // Use the lighter purple color
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              height: 80,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            // Product name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Product price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Rs.${product.price}',
                style: TextStyle(fontSize: 12),
              ),
            ),
            // Spacer to push icons to the bottom
            Spacer(),
            // Wishlist, Coupon, and Add to Cart icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 18,
                    icon: Icon(
                      Icons.favorite,
                      color: wishlistProvider.wishlist.contains(product)
                          ? Colors.red
                          : Colors.grey,
                    ),
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
                  ),
                  IconButton(
                    iconSize: 18,
                    icon: Icon(
                      Icons.card_giftcard,
                      color: Colors.orangeAccent,
                    ),
                    onPressed: () {
                     //do nothing
                    },
                  ),
                  IconButton(
                    iconSize: 18,
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: cartProvider.cart.contains(product)
                          ? Colors.green
                          : Colors.grey,
                    ),
                    onPressed: () {
                      if (!cartProvider.cart.contains(product)) {
                        cartProvider.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added to cart')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

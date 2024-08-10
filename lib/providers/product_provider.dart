import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: '1',
      name: 'Infinix Zero 30 4G ',
      description: "1 Year Brand Warranty, Display : 6.78 Inch AMOLED, 1B colors, 120HzOS , Android 13Memory : 8GB+8GB Exented RAM , 256GB ROMMain Camera : 108MP + 2MP + 2MP",
      price: 66000,
      imageUrl: 'https://www.pakmobizone.pk/wp-content/uploads/2023/10/Infinix-Zero-30-4G-Misty-Green-1.png',
      category: 'Electronics',
    ),
    Product(
      id: '2',
      name: 'Hair Clips',
      description: 'Material: Acrylic, Size: Hairpin is about 5.5CM long, Quantity: 10 pcs/set',
      price: 960,
      imageUrl: 'https://img.drz.lazcdn.com/static/pk/p/42f2fc82e5d2ae13131e2ab722a3567f.jpg_720x720q80.jpg_.webp',
      category: 'Clothing & Accessories',
    ),
    Product(
      id: '3',
      name: 'Air Pods',
      description: 'Battery life: 50 hrs,  Upto 50 Hours of Total Playtime',
      price: 2000,
      imageUrl: 'https://assets.myntassets.com/w_412,q_60,dpr_2,fl_progressive/assets/images/15622444/2023/6/15/414359a3-d249-45e3-89ee-87327078c1db1686812736703-NOISE-Buds-VS102-Truly-Wireless-Earbuds-with-50hrs-playtime--1.jpg',
      category: 'Electronics',
    ),
    Product(
      id: '4',
      name: 'Classic Ramekins',
      description: 'Heat Resistant Material: Made from durable materials designed to withstand high temperatures, they are both functional and stylish. ',
      price: 400,
      imageUrl: 'https://packit.pk/cdn/shop/files/buy-white-ramekins-online-Pakistan-PACKIT-home.webp?v=1712975242&width=600',
      category: 'Home & Kitchen',
    ),
    Product(
      id: '5',
      name: 'Sauce Bottles',
      description: 'Air Tight Leak-proof Cap, Capacity of 290 ml, Package beverages in style,Easy to Wash (dishwasher safe)',
      price: 125,
      imageUrl: 'https://packit.pk/cdn/shop/files/sauce-bottles-packaging-glass-bottles-with-metal-lids-for-drinks-liquid-ketchup-packing-made-in-Pakistan.webp?v=1706268251&width=600',
      category: 'Home & Kitchen',
    ),
    Product(
      id: '6',
      name: 'ClothingRack',
      description: 'No description',
      price: 3000,
      imageUrl: 'https://img.drz.lazcdn.com/static/pk/p/944177f546295a4f04ed4896e4ff2f05.jpg_720x720q80.jpg_.webp',
      category: 'Clothing & Accessories',
    ),
    Product(
      id: '7',
      name: 'Tripod/Monopod',
      description: 'Bubble Level, Strap Mount, Foam Leg Grip, Ballast Hook, Anodized Aluminum',
      price: 2500,
      imageUrl: 'https://static3.webx.pk/files/4679/Images/silicon-7862-1-4679-540142-171120055936.jpg',
      category: 'Electronics',
    ),
    Product(
      id: '8',
      name: 'Wooden Rack',
      description: 'pure wood frame rack,  black color, 12 inch by 8 inch, depth 2.3 inch',
      price: 360,
      imageUrl: 'https://img.drz.lazcdn.com/static/pk/p/f2ed28278e97f7087a295c6b6e568a42.jpg_720x720q80.jpg_.webp',
      category: 'Home & Kitchen',
    ),
    Product(
      id: '9',
      name: 'Slime Pack',
      description: "Make your own slime kit for kids 100% brand new easy to mix and make best glue and activator develop kids creativity make best slime at home make the best slimes at home best colors ",
      price: 350,
      imageUrl: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSHCzQzT3fqd9Rit9xNFH0uEtabiSDD_qoe7-RGulBEryzMtApO',
      category: 'Toys & Games',
    ),
    Product(
      id: '10',
      name: 'Rubiks Cube ',
      description: "Introducing the Stickerless 56mm Qiyi Warrior S Rubik's Cube 3x3! This magic speed cube puzzle toy is designed to enhance memory, responsiveness, and concentration. With its smooth and fast rotation, this Rubik's cube is perfect for both beginners and advanced cubers. The stickerless design adds durability and eliminates the hassle of peeling stickers. Whether you're a speedcuber or just enjoy a good brain teaser, this cube is a must-have for your collection.",
      price: 250,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRFAd62L48QUmUyn5WqfrKakZdJWSiy4JVdA&s',
      category: 'Toys & Games',
    ),
  ];

  List<Product> get products => _products;

  List<Product> searchProducts(String query) {
    return _products
        .where((product) =>
        product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  Product getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }
}

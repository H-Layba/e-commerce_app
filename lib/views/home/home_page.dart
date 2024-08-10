import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';
import '../../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _imageUrls = [
    'https://www.cartrollers.com/wp-content/uploads/2018/11/SLIDER-1-600x280.jpg',
    'https://img.freepik.com/premium-vector/mega-sale-advertiving-banner-with-3d-illustration-dofferent-home-smart-electronic-devices_348818-574.jpg',
    'https://www.shutterstock.com/image-vector/99-shopping-day-flash-sale-600nw-2183725351.jpg',
    'https://img.freepik.com/free-vector/realistic-beauty-sale-banner-with-discount_52683-94990.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          title: Text('Home'),
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.pushNamed(context, '/wishlist');
              },
            ),
            IconButton(
              icon: Icon(Icons.support),
              onPressed: () {
                Navigator.pushNamed(context, '/support');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search for products',
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                // Category Filter
                CategoryFilter(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
                SizedBox(height: 10),
                // Image Slider
                Container(
                  height: 200,
                  child: CarouselSlider.builder(
                    itemCount: _imageUrls.length,
                    itemBuilder: (context, index, realIndex) {
                      final url = _imageUrls[index];
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      viewportFraction: 1.0,
                      enlargeCenterPage: true,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Product Grid
                Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    List<Product> products = _searchQuery.isNotEmpty
                        ? productProvider.searchProducts(_searchQuery)
                        : _selectedCategory == 'All'
                        ? productProvider.products
                        : productProvider.getProductsByCategory(_selectedCategory);
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 19 / 20,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white70,
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                          textStyle: TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: Text('Go to Login'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/support/chat');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          foregroundColor: Colors.white70,
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                          textStyle: TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22), // Increase border radius for a larger button
                          ),
                        ),
                        child: Text('Go to Chat Support'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Icon(Icons.menu),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class CategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilter({
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'All', 'icon': 'https://img.icons8.com/color/48/000000/all.png'},
      {'name': 'Electronics', 'icon': 'https://img.icons8.com/color/48/000000/electronics.png'},
      {'name': 'Clothing & Accessories', 'icon': 'https://img.icons8.com/color/48/000000/clothes.png'},
      {'name': 'Home & Kitchen', 'icon': 'https://img.icons8.com/color/48/000000/home.png'},
      {'name': 'Beauty', 'icon': 'https://cdn-icons-png.flaticon.com/512/10786/10786565.png'},
      {'name': 'Toys & Games', 'icon': 'https://cdn-icons-png.freepik.com/512/4574/4574337.png'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = selectedCategory == category['name'];
          return GestureDetector(
            onTap: () => onCategorySelected(category['name']!),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.deepPurple : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(category['icon']!),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 5),
                  Text(
                    category['name']!,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: isSelected ? Colors.white : Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

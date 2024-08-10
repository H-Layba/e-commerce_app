import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  // Add category names and their corresponding image URLs
  final List<Map<String, String>> categories = [
    {'name': 'All', 'image': 'https://linktoallimage.jpg'},
    {'name': 'Electronics', 'image': 'https://linktoelectronicsimage.jpg'},
    {'name': 'Clothing & Accessories', 'image': 'https://linktoclothingimage.jpg'},
    {'name': 'Home & Kitchen', 'image': 'https://linktohomekitchenimage.jpg'},
    {'name': 'Beauty & Health', 'image': 'https://linktobeautyimage.jpg'},
    {'name': 'Sports & Outdoors', 'image': 'https://linktosportsimage.jpg'},
    {'name': 'Toys & Games', 'image': 'https://linktotoysimage.jpg'},
    {'name': 'Books & Media', 'image': 'https://linktobooksimage.jpg'},
    {'name': 'Office Supplies', 'image': 'https://linktoofficeimage.jpg'},
    {'name': 'Jewelry & Watches', 'image': 'https://linktojewelryimage.jpg'},
  ];

  CategoryFilter({required this.selectedCategory, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, // Adjusted height to accommodate images
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            return _buildCategoryChip(category['name']!, category['image']!);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category, String imageUrl) {
    final bool isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          onCategorySelected(category);
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 25, // Adjust the radius as needed
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.transparent,
              child: isSelected
                  ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              )
                  : null,
            ),
            SizedBox(height: 4),
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.deepPurple : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

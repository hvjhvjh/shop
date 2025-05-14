import 'package:flutter/material.dart';
import 'package:shop_app_flutter/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<Map<String, Object>> allProducts = [
    {
      'id': 1,
      'title': 'Men Nike Shoes',
      'price': 44.52,
      'imageUrl': 'assets/images/shoe1.jpg',
      'company': 'Nike',
      'sizes': [38, 39, 40, 41]
    },
    {
      'id': 2,
      'title': 'Addidas Shoes',
      'price': 20.12,
      'imageUrl': 'assets/images/shoe2.jpg',
      'company': 'Addidas',
      'sizes': [39, 40, 42]
    },
    {
      'id': 3,
      'title': 'Puma palermo',
      'price': 30.00,
      'imageUrl': 'assets/images/shoe3.jpg',
      'company': 'Puma',
      'sizes': [37, 38, 40]
    },
    {
      'id': 4,
      'title': 'Nike cortez',
      'price': 55.99,
      'imageUrl': 'assets/images/shoe4.jpg',
      'company': 'Nike',
      'sizes': [40, 41, 42, 43]
    },
  ];

  String selectedCategory = "All";
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final filteredProducts = allProducts.where((p) {
      final matchesCategory = selectedCategory == "All" ||
          (p['company'] as String).toLowerCase() == selectedCategory.toLowerCase();
      final matchesSearch = (p['title'] as String)
          .toLowerCase()
          .contains(searchText.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Shoes", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Text("Collection", style: TextStyle(fontSize: 28)),
            const SizedBox(height: 16),

            // Search
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                onChanged: (value) => setState(() => searchText = value),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Categories
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategory("All"),
                  _buildCategory("Addidas"),
                  _buildCategory("Nike"),
                  _buildCategory("Puma"),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Product Cards
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final p = filteredProducts[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsPage(product: p),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset(p['imageUrl'] as String, height: 180),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p['title'].toString(),
                                    style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text("\$${p['price']}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87)),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String label) {
    final isSelected = selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => selectedCategory = label),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.yellow[700] : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

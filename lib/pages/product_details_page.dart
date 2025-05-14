import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  void onAddToCart() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        ...widget.product,
        'size': selectedSize,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a size!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizes = widget.product['sizes'] as List<int>;

    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Column(
        children: [
          Text(widget.product['title'].toString(),
              style: Theme.of(context).textTheme.titleLarge),
          Image.asset(widget.product['imageUrl'] as String, height: 250),
          Text('\$${widget.product['price']}'),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sizes.length,
              itemBuilder: (context, index) {
                final size = sizes[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedSize = size),
                    child: Chip(
                      label: Text(size.toString()),
                      backgroundColor: selectedSize == size
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: onAddToCart,
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}

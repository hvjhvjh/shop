import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;

    double total = 0;
    for (var item in cart) {
      total += item['price'] as double;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cart.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];

                return ListTile(
                  leading: Image.asset(item['imageUrl'] as String, width: 50),
                  title: Text(item['title'].toString()),
                  subtitle: Text('Size: ${item['size']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<CartProvider>().removeProduct(item);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("\$${total.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

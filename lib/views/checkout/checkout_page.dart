import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

  bool _isSubmitting = false;

  void _submitOrder() async {
    if (_nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _zipController.text.isNotEmpty) {
      setState(() {
        _isSubmitting = true;
      });


      await Future.delayed(Duration(seconds: 2));


      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      cartProvider.clearCart();

      setState(() {
        _isSubmitting = false;
      });

      _nameController.clear();
      _phoneController.clear();
      _addressController.clear();
      _cityController.clear();
      _zipController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
      );


      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Enter your details:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _zipController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ZIP Code',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cart.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.cart[index];
                      return ListTile(
                        leading: Image.network(item.product.imageUrl),
                        title: Text(item.product.name),
                        subtitle: Text('\$${item.product.price} x ${item.quantity}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            cartProvider.removeFromCart(item.product);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitOrder,
                    child: _isSubmitting
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Place Order'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'cart_item.dart';
import 'package:uts/data.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cart;

  CartPage({required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KERANJANG'),
      ),
      body: ListView.builder(
        itemCount: widget.cart.length,
        itemBuilder: (context, index) {
          return CartItemDetail(
            cartItem: widget.cart[index],
            onRemove: () {
              _showConfirmationDialog(context, widget.cart[index]);
            },
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, CartItem cartItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus dari Keranjang'),
          content: Text(
              'Apakah Anda yakin ingin menghapus ${cartItem.book.title} dari keranjang?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                setState(() {
                  widget.cart.remove(cartItem);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class CartItemDetail extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;

  CartItemDetail({required this.cartItem, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              cartItem.book.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.book.title,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text('Jumlah: ${cartItem.quantity}'),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}

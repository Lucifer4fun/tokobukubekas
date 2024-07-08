import 'package:flutter/material.dart';
import 'package:collection/collection.dart'; // Import paket collection untuk firstWhereOrNull
import 'package:uts/cart_item/cart_item.dart'; // Import CartItem
import 'package:uts/data.dart';

import '../service_fb/service_fb.dart'; // Import Book

class CartProvider with ChangeNotifier {
  ServiceFb? sfb;
  List<CartItem>? _cart = [];

  List<CartItem>? get cart => _cart;

  get totalPrice => null;

  get items => null;

  addToCart(Book book) {
    sfb?.addcart(price: "30000", title: "judul buku", pages: "Halaman");

    var existingItem = _cart?.firstWhereOrNull((item) => item.book == book);

    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      _cart?.add(
          CartItem(book, 1)); // Menggunakan constructor CartItem yang sudah ada
      sfb?.addcart(price: "30000", title: "judul buku", pages: "Halaman");
    }

    notifyListeners();
  }

  void removeFromCart(Book book) {
    _cart?.removeWhere((item) => item.book == book);
    notifyListeners();
  }

  int get cartCount =>
      _cart?.fold(0, (total, item) => (total ?? 0) + item.quantity) ?? 0;
}

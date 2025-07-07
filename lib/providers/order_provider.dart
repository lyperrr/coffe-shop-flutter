import 'package:flutter/material.dart';

class OrderItem {
  final String name;
  final String price;
  final int quantity;
  final String imageBase64;

  OrderItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageBase64,
  });
}

class OrderProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders => _orders;

  void addOrder(OrderItem order) {
    final index = _orders.indexWhere((o) => o.name == order.name);

    if (index != -1) {
      _orders[index] = OrderItem(
        name: _orders[index].name,
        price: _orders[index].price,
        quantity: _orders[index].quantity + order.quantity,
        imageBase64: _orders[index].imageBase64,
      );
    } else {
      _orders.add(order);
    }

    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}

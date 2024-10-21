
import 'package:laticraftproject/data/models/storeowner_product.dart';

class Order {
  final String id;
  final String customerId; // Store customer ID
  final String storeId; // Store store ID
  final List<OrderProduct> products; // List of products in the order
  final double totalAmount;
  final String status;
  final String shippingAddress;
  final String paymentMethod;
  final DateTime placedAt;

  Order({
    required this.id,
    required this.customerId,
    required this.storeId,
    required this.products,
    required this.totalAmount,
    required this.status,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.placedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      customerId: json['customer']['_id'], // Extract customer ID
      storeId: json['store'], // Store ID is directly accessible
      products: (json['products'] as List)
          .map((product) => OrderProduct.fromJson(product))
          .toList(),
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
      shippingAddress: json['shippingAddress'],
      paymentMethod: json['paymentMethod'],
      placedAt: DateTime.parse(json['placedAt']),
    );
  }
}

class OrderProduct {
  final String id;
  final StoreOwnerProduct product; // Use StoreOwnerProduct class
  final int quantity;
  final String image;

  OrderProduct({
    required this.id,
    required this.product,
    required this.quantity,
    required this.image,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['_id'],
      product: StoreOwnerProduct.fromJson(json['product']),
      quantity: json['quantity'],
      image: json['image'],
    );
  }
}

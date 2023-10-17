import 'package:chandlier/data/models/order/order_model.dart';

class CheckoutModel {
  final String fullName;
  final String address;
  final String checkoutId;
  final List<OrderModel> orders;
  final String grandTotal;

  CheckoutModel(
      {required this.fullName,
      required this.checkoutId,
      required this.address,
      required this.orders,
      required this.grandTotal});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
      fullName: json['fullName'],
      checkoutId: json['checkoutId'],
      address: json['address'],
      orders: (json["orders"] as List?)
              ?.map((e) => OrderModel.fromJson(e))
              .toList() ??
          [],
      grandTotal: json['grandTotal']);

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'address': address,
      'checkoutId': checkoutId,
      'orders': orders.map((e) => e.productName),
      'grandTotal': grandTotal
    };
  }
}

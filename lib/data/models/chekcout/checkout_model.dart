import 'package:chandlier/data/models/order/order_model.dart';

class CheckoutModel{
  final String fullName;
  final String address;
  final List<OrderModel> orders;
  final String grandTotal;

  CheckoutModel({required this.fullName,required this.address,required this.orders,required this.grandTotal});




}
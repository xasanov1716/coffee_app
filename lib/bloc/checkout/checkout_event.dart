part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class AddCheckout extends CheckoutEvent {
  final CheckoutModel checkoutModel;
  AddCheckout({required this.checkoutModel});
}

class DeleteCheckout extends CheckoutEvent {
  final String id;
  DeleteCheckout({required this.id});
}
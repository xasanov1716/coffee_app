part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}


class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final List<CheckoutModel> checkoutModel;

  CheckoutSuccess({required this.checkoutModel});
}


class CheckoutError extends CheckoutState {
  final String errorText;
  CheckoutError({required this.errorText});
}
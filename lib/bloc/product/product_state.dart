
import 'package:chandlier/data/models/coffee/coffee_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}


class ProductLoadingState extends ProductState {}


class ProductErrorState extends ProductState {
  final String errorText;

  ProductErrorState({required this.errorText});
}


class ProductSuccessState extends ProductState {
  final List<CoffeeModel> coffeeModel;

  ProductSuccessState({required this.coffeeModel});
}
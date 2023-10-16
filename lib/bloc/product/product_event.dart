import 'package:chandlier/data/models/coffee/coffee_model.dart';

abstract class ProductEvent {}


class AddProductEvent extends ProductEvent {
  final CoffeeModel coffeeModel;

  AddProductEvent({required this.coffeeModel});
}


class UpdateProductEvent extends ProductEvent {
  final CoffeeModel coffeeModel;

  UpdateProductEvent({required this.coffeeModel});
}

class GetProductByIdEvent extends ProductEvent {
  final String id;

  GetProductByIdEvent({required this.id});
}



class DeleteProductEvent extends ProductEvent {
  final String id;

  DeleteProductEvent({required this.id});
}
import 'package:chandlier/data/firebase/category_service.dart';
import 'package:chandlier/data/firebase/order_service.dart';
import 'package:chandlier/data/firebase/product_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void getItSetup() {
  getIt.registerLazySingleton<ProductsService>(() => ProductsService());
  getIt.registerLazySingleton<CategoryService>(() => CategoryService());
  getIt.registerLazySingleton<OrderService>(() => OrderService());
}
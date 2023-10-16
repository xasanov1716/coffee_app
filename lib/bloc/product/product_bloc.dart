
import 'package:chandlier/data/firebase/product_service.dart';
import 'package:chandlier/data/models/coffee/coffee_model.dart';
import 'package:chandlier/data/models/universal_data.dart';
import 'package:chandlier/service/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chandlier/bloc/product/product_state.dart';

import 'product_event.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<AddProductEvent>(_addProduct);
    on<UpdateProductEvent>(_updateProduct);
    on<DeleteProductEvent>(_deleteProduct);
    on<GetProductByIdEvent>(_getProductById);
  }

  String imageUrl = '';

  _addProduct(AddProductEvent event, Emitter<ProductState> emit)async{
    emit(ProductLoadingState());
     UniversalData data =  await getIt.get<ProductsService>().addProduct(coffeeModel: event.coffeeModel);
     if(data.error.isEmpty){
      emit(ProductSuccessState(coffeeModel: []));
     }else{
       emit(ProductErrorState(errorText: data.error));
     }
  }


  _getProductById(GetProductByIdEvent event, Emitter<ProductState> emit)async{
    emit(ProductLoadingState());
    List<CoffeeModel> coffee;
    coffee = getIt.get<ProductsService>().getProducts(event.id) as List<CoffeeModel>;
    if(coffee.isNotEmpty){
      emit(ProductSuccessState(coffeeModel: coffee));
    }else{
      emit(ProductErrorState(errorText: 'Other Error'));
    }
  }

  _updateProduct(UpdateProductEvent event, Emitter<ProductState> emit)async{
    emit(ProductLoadingState());
    UniversalData data =  await getIt.get<ProductsService>().updateProduct(coffeeModel: event.coffeeModel);
    if(data.error.isEmpty){
      emit(ProductSuccessState(coffeeModel: []));
    }else{
      emit(ProductErrorState(errorText: data.error));
    }
  }


  _deleteProduct(DeleteProductEvent event, Emitter<ProductState> emit)async{
    emit(ProductLoadingState());
    UniversalData data =  await getIt.get<ProductsService>().deleteProduct(coffeeId: event.id);
    if(data.error.isEmpty){
      emit(ProductSuccessState(coffeeModel: []));
    }else{
      emit(ProductErrorState(errorText: data.error));
    }
  }


}

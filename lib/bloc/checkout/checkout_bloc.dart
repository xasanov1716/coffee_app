import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chandlier/data/firebase/checkout_service.dart';
import 'package:chandlier/data/models/chekcout/checkout_model.dart';
import 'package:chandlier/data/models/universal_data.dart';
import 'package:chandlier/service/service_locator.dart';
import 'package:meta/meta.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
   on<AddCheckout>(_addCheckout);
   on<DeleteCheckout>(_deleteCheckout);
  }

  _addCheckout(AddCheckout event,Emitter<CheckoutState> emit)async{
    emit(CheckoutLoading());
    UniversalData data = await getIt.get<CheckOutService>().addCheckout(checkOutModel: event.checkoutModel);
    if(data.error.isEmpty){
      emit(CheckoutSuccess(checkoutModel: const []));
    }else{
      emit(CheckoutError(errorText: data.error));
    }
  }

  _deleteCheckout(DeleteCheckout event,Emitter<CheckoutState> emit)async{
    emit(CheckoutLoading());
    UniversalData data = await getIt.get<CheckOutService>().deleteCheckout(id: event.id);
    if(data.error.isEmpty){
      emit(CheckoutSuccess(checkoutModel: const []));
    }else{
      emit(CheckoutError(errorText: data.error));
    }
  }
}

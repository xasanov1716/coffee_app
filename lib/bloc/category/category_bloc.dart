
import 'package:chandlier/bloc/category/category_event.dart';
import 'package:chandlier/bloc/category/category_state.dart';
import 'package:chandlier/data/firebase/category_service.dart';
import 'package:chandlier/data/models/universal_data.dart';
import 'package:chandlier/service/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<AddCategoryEvent>(_addCategory);
    on<DeleteCategoryEvent>(_deleteCategory);
    on<UpdateCategoryEvent>(_updateCategory);
  }



  _addCategory(AddCategoryEvent event, Emitter<CategoryState> emit)async{
    emit(CategoryLoadingState());
    UniversalData data =  await getIt.get<CategoryService>().addCategory(categoryModel: event.categoryModel);
    if(data.error.isEmpty){
      emit(CategorySuccessState());
      debugPrint('CATEGORY ADD ISHLADI');
    }else{
      emit(CategoryErrorState(errorText: data.error));
    }
  }


  _updateCategory(UpdateCategoryEvent event, Emitter<CategoryState> emit)async{
    emit(CategoryLoadingState());
    UniversalData data =  await getIt.get<CategoryService>().updateCategory(categoryModel: event.categoryModel);
    if(data.error.isEmpty){
      emit(CategorySuccessState());
    }else{
      emit(CategoryErrorState(errorText: data.error));
    }
  }


  _deleteCategory(DeleteCategoryEvent event, Emitter<CategoryState> emit)async{
    emit(CategoryLoadingState());
    UniversalData data =  await getIt.get<CategoryService>().deleteCategory(categoryId: event.id);
    if(data.error.isEmpty){
      emit(CategorySuccessState());
    }else{
      emit(CategoryErrorState(errorText: data.error));
    }
  }

}
